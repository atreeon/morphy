import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dartx/dartx.dart';
import 'package:morphy/src/common/GeneratorForAnnotationX.dart';
import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';
import 'package:morphy/src/common/helpers.dart';
import 'package:morphy/src/createMorphy.dart';
import 'package:morphy/src/helpers.dart';
import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as p;

class MorphyGenerator<TValueT extends MorphyX>
    extends GeneratorForAnnotationX<TValueT> {
  static final Map<String, ClassElement> _allAnnotatedClasses = {};
  static final Map<String, List<InterfaceType>> _allImplementedInterfaces = {};
  static Map<String, ClassElement> get allAnnotatedClasses =>
      _allAnnotatedClasses;

  @override
  TypeChecker get typeChecker => TypeChecker.fromRuntime(TValueT);

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    // First pass: collect all annotated classes
    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      if (annotatedElement.element is ClassElement) {
        var element = annotatedElement.element as ClassElement;
        _allAnnotatedClasses[element.name] = element;
        _allImplementedInterfaces[element.name] = element.interfaces;
      }
    }

    return super.generate(library, buildStep);
  }

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
    List<ClassElement> allClasses,
  ) {
    var sb = StringBuffer();

    if (element is! ClassElement) {
      throw Exception("not a class");
    }

    _allAnnotatedClasses[element.name] = element;

    // Verify required imports
    verifyRequiredImports(element, buildStep);

    var hasConstConstructor = element.constructors.any((e) => e.isConst);
    var isAbstract = element.name.startsWith("\$\$");
    var nonSealed = annotation.read('nonSealed').boolValue;

    // If this is implementing a sealed class, verify it's in the same library
    for (var interface in element.interfaces) {
      var interfaceName = interface.element.name;
      // Only check if:
      // 1. The interface is a sealed class (starts with $$)
      // 2. This class is a concrete implementation (doesn't start with $)
      if (interfaceName.startsWith("\$\$") && !element.name.startsWith("\$")) {
        var sealedLibrary = interface.element.library;
        var implementationLibrary = element.library;

        // Check if they're in the same library (includes part files)
        var isSameLibrary = sealedLibrary == implementationLibrary ||
            implementationLibrary.parts
                .any((part) => part.library == sealedLibrary) ||
            sealedLibrary.parts
                .any((part) => part.library == implementationLibrary);

        if (!isSameLibrary) {
          throw Exception(
              'Class ${element.name} must be in the same library as its sealed superclass ${interfaceName}. ' +
                  'Either move it to the same library or use "part of" directive.');
        }
      }
    }

    if (element.supertype?.element.name != "Object") {
      throw Exception("you must use implements, not extends");
    }

    var docComment = element.documentationComment;

    // Collect all interfaces including the inheritance chain
    var allInterfaces = <InterfaceType>[];
    var processedInterfaces = <String>{};

    void addInterface(InterfaceType interface) {
      if (processedInterfaces.contains(interface.element.name)) return;
      processedInterfaces.add(interface.element.name);
      allInterfaces.add(interface);

      // Add super interfaces
      interface.element.interfaces.forEach(addInterface);
      interface.element.allSupertypes
          .where((t) => t.element.name != 'Object')
          .forEach(addInterface);
    }

    // Process all interfaces
    element.interfaces.forEach(addInterface);

    var interfaces = allInterfaces.map((e) {
      var interfaceName = e.element.name;
      // For $$-prefixed interfaces, use the non-sealed interface class name
      var implementedName = interfaceName.startsWith("\$\$")
          ? interfaceName.replaceAll("\$\$", "")
          : interfaceName.replaceAll("\$", "");

      return InterfaceWithComment(
        implementedName,
        e.typeArguments.map(typeToString).toList(),
        e.element.typeParameters.map((x) => x.name).toList(),
        e.element.fields
            .map((e) => NameType(e.name, typeToString(e.type)))
            .toList(),
        comment: e.element.documentationComment,
      );
    }).toList();

    // Get all fields including those from the entire inheritance chain
    var allFields = getAllFieldsIncludingSubtypes(element);
    var allFieldsDistinct = getDistinctFields(allFields, interfaces);

    var classGenerics = element.typeParameters.map((e) {
      final bound = e.bound;
      return NameTypeClassComment(
          e.name, bound == null ? null : typeToString(bound), null);
    }).toList();

    var typesExplicit = <Interface>[];
    if (!annotation.read('explicitSubTypes').isNull) {
      typesExplicit = annotation.read('explicitSubTypes').listValue.map((x) {
        if (x.toTypeValue()?.element is! ClassElement) {
          throw Exception("each type for the copywith def must all be classes");
        }

        var el = x.toTypeValue()?.element as ClassElement;
        _allAnnotatedClasses[el.name] = el;

        return Interface.fromGenerics(
          el.name,
          el.typeParameters.map((TypeParameterElement x) {
            final bound = x.bound;
            return NameType(x.name, bound == null ? null : typeToString(bound));
          }).toList(),
          getAllFieldsIncludingSubtypes(el)
              .where((x) => x.name != "hashCode")
              .toList(),
          true,
        );
      }).toList();
    }

    // Process all interfaces including the inheritance chain
    var allValueTInterfaces = allInterfaces
        .map((e) => Interface.fromGenerics(
              e.element.name,
              e.element.typeParameters.map((TypeParameterElement x) {
                final bound = x.bound;
                return NameType(
                    x.name, bound == null ? null : typeToString(bound));
              }).toList(),
              getAllFieldsIncludingSubtypes(e.element as ClassElement)
                  .where((x) => x.name != "hashCode")
                  .toList(),
            ))
        .union(typesExplicit)
        .distinctBy((element) => element.interfaceName)
        .toList();

    sb.writeln(createMorphy(
      isAbstract,
      allFieldsDistinct,
      element.name,
      docComment ?? "",
      interfaces,
      allValueTInterfaces,
      classGenerics,
      hasConstConstructor,
      annotation.read('generateJson').boolValue,
      annotation.read('hidePublicConstructor').boolValue,
      typesExplicit,
      nonSealed,
      annotation.read('explicitToJson').boolValue,
      annotation.read('generateCompareTo').boolValue,
    ));

    return sb.toString();
  }

  List<NameTypeClassComment> getAllFieldsIncludingSubtypes(
      ClassElement element) {
    var fields = <NameTypeClassComment>[];
    var processedTypes = <String>{};

    void addFields(ClassElement element) {
      if (processedTypes.contains(element.name)) return;
      processedTypes.add(element.name);

      fields.addAll(getAllFields(element.allSupertypes, element)
          .where((x) => x.name != "hashCode"));

      // Process interfaces
      for (var interface in element.interfaces) {
        if (_allAnnotatedClasses.containsKey(interface.element.name)) {
          addFields(_allAnnotatedClasses[interface.element.name]!);
        }
      }
    }

    addFields(element);
    return fields.distinctBy((f) => f.name).toList();
  }

  List<InterfaceType> getAllImplementedInterfaces(ClassElement element) {
    var interfaces = <InterfaceType>[];
    var processedInterfaces = <String>{};
    var queue = element.interfaces.toList();

    while (queue.isNotEmpty) {
      var current = queue.removeAt(0);
      if (processedInterfaces.contains(current.element.name)) continue;
      processedInterfaces.add(current.element.name);

      interfaces.add(current);
      queue.addAll(current.element.interfaces);

      if (_allImplementedInterfaces.containsKey(current.element.name)) {
        queue.addAll(_allImplementedInterfaces[current.element.name]!);
      }
    }

    return interfaces;
  }

  void verifyRequiredImports(ClassElement element, BuildStep buildStep) {
    var sourceLibrary = element.library;
    var requiredTypes = collectRequiredTypes(element);
    var missingImports = <String>{};

    var sourceUri = sourceLibrary.source.uri;

    // Get the package name from the build step
    var packageName = buildStep.inputId.package;
    var packagePrefix = 'package:$packageName/';

    for (var typeElement in requiredTypes) {
      var targetLibrary = typeElement.library;
      if (targetLibrary != null &&
          targetLibrary != sourceLibrary &&
          !sourceLibrary.libraryImports
              .any((import) => import.importedLibrary == targetLibrary)) {
        var targetUri = targetLibrary.source.uri;

        String importUri;

        if (sourceUri.scheme == 'package' && targetUri.scheme == 'package') {
          if (sourceUri.toString().startsWith(packagePrefix) &&
              targetUri.toString().startsWith(packagePrefix)) {
            // Both URIs are in the same package, compute relative path
            var sourcePath = sourceUri.path.substring(
                packageName.length + 1); // Remove 'package:' and package name
            var targetPath = targetUri.path.substring(packageName.length + 1);

            var relativePath =
                p.relative(targetPath, from: p.dirname(sourcePath));
            // Ensure the relative path uses forward slashes
            importUri = relativePath.replaceAll('\\', '/');
          } else {
            // Different packages, cannot compute relative path
            importUri = targetUri.toString();
          }
        } else if (sourceUri.scheme == targetUri.scheme &&
            sourceUri.scheme == 'file') {
          // Both URIs are file URIs
          var sourcePath = sourceUri.toFilePath();
          var targetPath = targetUri.toFilePath();

          var relativePath =
              p.relative(targetPath, from: p.dirname(sourcePath));
          // Ensure the relative path uses forward slashes
          importUri = relativePath.replaceAll('\\', '/');
        } else {
          // Different schemes or cannot compute relative path
          importUri = targetUri.toString();
        }

        missingImports.add(importUri);
      }
    }

    if (missingImports.isNotEmpty) {
      var imports =
          missingImports.map((importUri) => "import '$importUri';").join('\n');
      throw Exception('''
  Missing required imports in ${sourceLibrary.source.uri}:
$imports
  ''');
    }
  }

  Set<ClassElement> collectRequiredTypes(ClassElement element) {
    var types = <ClassElement>{};

    // Add implemented interfaces and their inheritance chain
    for (var interface in element.interfaces) {
      if (interface.element is ClassElement) {
        types.add(interface.element as ClassElement);
      }
    }

    // Add supertypes
    for (var supertype in element.allSupertypes) {
      if (supertype.element is ClassElement) {
        types.add(supertype.element as ClassElement);
      }
    }

    // Add explicit subtypes from annotation
    var annotation = typeChecker.firstAnnotationOf(element);
    if (annotation != null) {
      var reader = ConstantReader(annotation);
      if (!reader.read('explicitSubTypes').isNull) {
        var subtypes = reader.read('explicitSubTypes').listValue;
        for (var type in subtypes) {
          if (type.toTypeValue()?.element is ClassElement) {
            types.add(type.toTypeValue()!.element as ClassElement);
          }
        }
      }
    }

    return types;
  }
}
