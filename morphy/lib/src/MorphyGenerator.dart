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

class MorphyGenerator<TValueT extends MorphyX>
    extends GeneratorForAnnotationX<TValueT> {
  // Static maps to store class information across all files
  static final Map<String, ClassElement> _allAnnotatedClasses = {};
  static final Map<String, List<InterfaceType>> _allImplementedInterfaces = {};
  static Map<String, ClassElement> get allAnnotatedClasses =>
      _allAnnotatedClasses;
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

    // Second pass: generate code
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

    // Verify required imports
    verifyRequiredImports(element);

    allAnnotatedClasses[element.name] = element;

    var hasConstConstructor = element.constructors.any((e) => e.isConst);

    if (element.supertype?.element.name != "Object") {
      throw Exception("you must use implements, not extends");
    }

    var docComment = element.documentationComment;
    var isAbstract = element.name.startsWith("\$\$");

    // Get all fields including those from implemented interfaces and their subtypes
    var allFields = getAllFieldsIncludingSubtypes(element);

    var className = element.name;
    var interfaces = element.interfaces
        .map((e) => InterfaceWithComment(
              e.element.name,
              e.typeArguments.map(typeToString).toList(),
              e.element.typeParameters.map((x) => x.name).toList(),
              e.element.fields
                  .map((e) => NameType(e.name, typeToString(e.type)))
                  .toList(),
              comment: e.element.documentationComment,
            ))
        .toList();

    var classGenerics = element.typeParameters.map((e) {
      final bound = e.bound;
      return NameTypeClassComment(
          e.name, bound == null ? null : typeToString(bound), null);
    }).toList();

    var allFieldsDistinct = getDistinctFields(allFields, interfaces);

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

    var allValueTInterfaces = element.interfaces
        .expand((e) =>
            [e, ...getAllImplementedInterfaces(e.element as ClassElement)])
        .map(
          (e) => Interface.fromGenerics(
            e.element.name,
            e.element.typeParameters.map((TypeParameterElement x) {
              final bound = x.bound;
              return NameType(
                  x.name, bound == null ? null : typeToString(bound));
            }).toList(),
            getAllFieldsIncludingSubtypes(e.element as ClassElement)
                .where((x) => x.name != "hashCode")
                .toList(),
          ),
        )
        .union(typesExplicit)
        .distinctBy((element) => element.interfaceName)
        .toList();

    sb.writeln(createMorphy(
      isAbstract,
      allFieldsDistinct,
      className,
      docComment ?? "",
      interfaces,
      allValueTInterfaces,
      classGenerics,
      hasConstConstructor,
      annotation.read('generateJson').boolValue,
      annotation.read('hidePublicConstructor').boolValue,
      typesExplicit,
      annotation.read('nonSealed').boolValue,
      annotation.read('explicitToJson').boolValue,
    ));

    return sb.toString();
  }

  List<NameTypeClassComment> getAllFieldsIncludingSubtypes(
      ClassElement element) {
    var fields = getAllFields(element.allSupertypes, element)
        .where((x) => x.name != "hashCode")
        .toList();

    // Add fields from implemented interfaces
    for (var interface in element.interfaces) {
      if (_allAnnotatedClasses.containsKey(interface.element.name)) {
        var interfaceElement = _allAnnotatedClasses[interface.element.name]!;
        fields.addAll(
            getAllFields(interfaceElement.allSupertypes, interfaceElement)
                .where((x) => x.name != "hashCode"));
      }
    }

    return fields;
  }

  List<InterfaceType> getAllImplementedInterfaces(ClassElement element) {
    var interfaces = <InterfaceType>[];
    var queue = element.interfaces.toList();

    while (queue.isNotEmpty) {
      var current = queue.removeAt(0);
      interfaces.add(current);

      if (_allImplementedInterfaces.containsKey(current.element.name)) {
        queue.addAll(_allImplementedInterfaces[current.element.name]!);
      }
    }

    return interfaces;
  }

  void verifyRequiredImports(ClassElement element) {
    var sourceLibrary = element.library;
    var requiredTypes = collectRequiredTypes(element);
    var missingImports = <String>{};

    for (var typeName in requiredTypes) {
      var typeElement = _allAnnotatedClasses[typeName];
      if (typeElement != null &&
          typeElement.library != sourceLibrary &&
          !sourceLibrary.importedLibraries
              .any((lib) => lib == typeElement.library)) {
        missingImports.add(typeElement.library.source.uri.toString());
      }
    }

    if (missingImports.isNotEmpty) {
      throw Exception('''
  Missing required imports in ${sourceLibrary.source.uri}:
  ${missingImports.map((import) => "import '$import';").join('\n')}
  ''');
    }
  }

  Set<String> collectRequiredTypes(ClassElement element) {
    var types = <String>{};

    // Add implemented interfaces
    for (var interface in element.interfaces) {
      types.add(interface.element.name);
    }

    // Add explicit subtypes from annotation
    var annotation = typeChecker.firstAnnotationOf(element);
    if (annotation != null) {
      var reader = ConstantReader(annotation);
      if (!reader.read('explicitSubTypes').isNull) {
        var subtypes = reader.read('explicitSubTypes').listValue;
        for (var type in subtypes) {
          if (type.toTypeValue()?.element is ClassElement) {
            types.add((type.toTypeValue()?.element as ClassElement).name);
          }
        }
      }
    }

    return types;
  }
}
