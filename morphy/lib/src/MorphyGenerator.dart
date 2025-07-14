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
import 'package:morphy/src/factory_method.dart';
import 'package:morphy/src/helpers.dart';
import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

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
        var isSameLibrary =
            sealedLibrary == implementationLibrary ||
            implementationLibrary.definingCompilationUnit.library ==
                sealedLibrary ||
            sealedLibrary.definingCompilationUnit.library ==
                implementationLibrary;

        if (!isSameLibrary) {
          throw Exception(
            'Class ${element.name} must be in the same library as its sealed superclass ${interfaceName}. ' +
                'Either move it to the same library or use "part of" directive.',
          );
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

    // Get factory methods from the abstract class
    var factoryMethods = getFactoryMethods(element);

    var classGenerics = element.typeParameters.map((e) {
      final bound = e.bound;
      return NameTypeClassComment(
        e.name,
        bound == null ? null : typeToString(bound),
        null,
      );
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
          getAllFieldsIncludingSubtypes(
            el,
          ).where((x) => x.name != "hashCode").toList(),
          true,
        );
      }).toList();
    }

    // Process all interfaces including the inheritance chain
    var allValueTInterfaces = allInterfaces
        .map(
          (e) => Interface.fromGenerics(
            e.element.name,
            e.element.typeParameters.map((TypeParameterElement x) {
              final bound = x.bound;
              return NameType(
                x.name,
                bound == null ? null : typeToString(bound),
              );
            }).toList(),
            getAllFieldsIncludingSubtypes(
              e.element as ClassElement,
            ).where((x) => x.name != "hashCode").toList(),
          ),
        )
        .union(typesExplicit)
        .distinctBy((element) => element.interfaceName)
        .toList();

    sb.writeln(
      createMorphy(
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
        factoryMethods,
      ),
    );

    return sb.toString();
  }

  List<NameTypeClassComment> getAllFieldsIncludingSubtypes(
    ClassElement element,
  ) {
    var fields = <NameTypeClassComment>[];
    var processedTypes = <String>{};

    void addFields(ClassElement element) {
      if (processedTypes.contains(element.name)) return;
      processedTypes.add(element.name);

      fields.addAll(
        getAllFields(
          element.allSupertypes,
          element,
        ).where((x) => x.name != "hashCode"),
      );

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
      if (targetLibrary != sourceLibrary &&
          !sourceLibrary.importedLibraries.any(
            (library) => library == targetLibrary,
          )) {
        var targetUri = targetLibrary.source.uri;

        String importUri;

        if (sourceUri.scheme == 'package' && targetUri.scheme == 'package') {
          if (sourceUri.toString().startsWith(packagePrefix) &&
              targetUri.toString().startsWith(packagePrefix)) {
            // Both URIs are in the same package, compute relative path
            var sourcePath = sourceUri.path.substring(
              packageName.length + 1,
            ); // Remove 'package:' and package name
            var targetPath = targetUri.path.substring(packageName.length + 1);

            var relativePath = p.relative(
              targetPath,
              from: p.dirname(sourcePath),
            );
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

          var relativePath = p.relative(
            targetPath,
            from: p.dirname(sourcePath),
          );
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
      var imports = missingImports
          .map((importUri) => "import '$importUri';")
          .join('\n');
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

  List<FactoryMethodInfo> getFactoryMethods(ClassElement element) {
    var factoryMethods = <FactoryMethodInfo>[];

    for (var constructor in element.constructors) {
      if (constructor.isFactory && constructor.name.isNotEmpty) {
        var methodName = constructor.name;
        var parameters = constructor.parameters.map((param) {
          var paramType = param.type.toString();

          // Handle self-referencing types
          if (paramType.contains('InvalidType') || paramType == 'dynamic') {
            var className = element.name.replaceAll('\$', '');

            // Check if this is a self-reference to the current class
            if (param.type.element?.displayName == element.name ||
                param.type.element?.displayName == className) {
              paramType = className;
            } else {
              // For InvalidType, try to resolve from the source code
              try {
                var constructorSource = constructor.source.contents.data;

                // Look for the parameter in the factory method signature
                var factoryPattern = RegExp(
                  r'factory\s+\$' +
                      RegExp.escape(className) +
                      r'\.' +
                      RegExp.escape(constructor.name) +
                      r'\s*\(([^)]*)\)',
                  multiLine: true,
                );

                var factoryMatch = factoryPattern.firstMatch(constructorSource);
                if (factoryMatch != null) {
                  var paramsList = factoryMatch.group(1) ?? '';

                  // Extract parameter definitions
                  var paramPattern = RegExp(
                    r'(?:required\s+)?([A-Za-z_][A-Za-z0-9_]*(?:<[^>]+>)?(?:\?)?)\s+' +
                        RegExp.escape(param.name),
                  );

                  var paramMatch = paramPattern.firstMatch(paramsList);
                  if (paramMatch != null) {
                    var sourceType = paramMatch.group(1)!;

                    // If the source type references the class name, use the clean class name
                    // but preserve nullable markers
                    if (sourceType == className ||
                        sourceType == element.name.replaceAll('\$', '') ||
                        sourceType == '$className?' ||
                        sourceType == '${element.name.replaceAll('\$', '')}?') {
                      paramType = sourceType
                          .replaceAll('\$', '')
                          .replaceAll(
                            element.name.replaceAll('\$', ''),
                            className,
                          );
                    } else if (sourceType.contains(className)) {
                      paramType = sourceType.replaceAll('\$', '');
                    } else if (sourceType.contains('List<$className>') ||
                        sourceType.contains('List<$className?>') ||
                        sourceType.contains(
                          'List<${element.name.replaceAll('\$', '')}>',
                        ) ||
                        sourceType.contains(
                          'List<${element.name.replaceAll('\$', '')}?>',
                        )) {
                      paramType = sourceType
                          .replaceAll('\$', '')
                          .replaceAll(
                            element.name.replaceAll('\$', ''),
                            className,
                          );
                    } else {
                      // Use the source type as-is, but clean dollar signs
                      paramType = sourceType.replaceAll('\$', '');
                    }
                  }
                }
              } catch (e) {
                // If source parsing fails, try basic InvalidType replacement
                if (paramType.contains('InvalidType')) {
                  paramType = paramType.replaceAll('InvalidType', className);
                }
              }
            }
          }

          return FactoryParameterInfo(
            name: param.name,
            type: paramType,
            isRequired: param.isRequiredNamed || param.isRequiredPositional,
            isNamed: param.isNamed,
            hasDefaultValue: param.hasDefaultValue,
            defaultValue: param.defaultValueCode,
          );
        }).toList();

        // Get the constructor body if available (for simple factory constructors)
        var bodyCode = _extractFactoryBody(constructor);

        factoryMethods.add(
          FactoryMethodInfo(
            name: methodName,
            parameters: parameters,
            bodyCode: bodyCode,
            className: element.name,
          ),
        );
      }
    }

    return factoryMethods;
  }

  String _extractFactoryBody(ConstructorElement constructor) {
    // Try to extract the factory body from source using simple pattern matching
    try {
      var source = constructor.source.contents.data;
      var factoryName = constructor.name;
      var className = constructor.enclosingElement3.name.replaceAll('\$', '');

      // Create a more flexible pattern that handles multi-line factory methods
      // First escape special regex characters in class and factory names
      var escapedClassName = RegExp.escape(className);
      var escapedFactoryName = RegExp.escape(factoryName);

      // Find the start of the factory method
      var factoryStartPattern = RegExp(
        r'factory\s+\$' +
            escapedClassName +
            r'\.' +
            escapedFactoryName +
            r'\s*\([^)]*\)\s*=>\s*',
        multiLine: true,
      );

      var startMatch = factoryStartPattern.firstMatch(source);
      if (startMatch != null) {
        var startPos = startMatch.end;
        var remainingSource = source.substring(startPos);

        // Find the matching semicolon that ends the factory
        var depth = 0;
        var inString = false;
        var stringChar = '';
        var endPos = -1;

        for (int i = 0; i < remainingSource.length; i++) {
          var char = remainingSource[i];

          if (!inString) {
            if (char == '"' || char == "'") {
              inString = true;
              stringChar = char;
            } else if (char == '(') {
              depth++;
            } else if (char == ')') {
              depth--;
            } else if (char == ';' && depth == 0) {
              endPos = i;
              break;
            }
          } else {
            if (char == stringChar &&
                (i == 0 || remainingSource[i - 1] != r'\')) {
              inString = false;
            }
          }
        }

        if (endPos != -1) {
          var body = remainingSource.substring(0, endPos).trim();

          // Transform $ClassName to ClassName
          body = body.replaceAll(RegExp(r'\$(\w+)'), r'\1');
          return 'return ' + body + ';';
        }
      }
    } catch (e) {
      // Fall back to default if parsing fails
    }
    // Default implementation - use constructor parameters
    var className = constructor.enclosingElement3.name.replaceAll('\$', '');
    var paramList = constructor.parameters
        .map((p) => '${p.name}: ${p.name}')
        .join(', ');
    return 'return ${className}._(${paramList});';
  }

  String _fixSelfReferencingType(
    String type,
    String originalClassName,
    String targetClassName,
  ) {
    // Handle InvalidType which often indicates unresolved self-references
    if (type.contains('InvalidType')) {
      // Replace InvalidType with the target class name, preserving nullability and generics
      var result = type.replaceAll('InvalidType', targetClassName);
      return result;
    }

    // Handle direct references to the original class name (with $)
    if (type.contains(originalClassName)) {
      return type.replaceAll(originalClassName, targetClassName);
    }

    // Handle cases where the type is just 'dynamic' but should be self-referencing
    // Try to determine from context if this should be the target class
    if (type == 'dynamic') {
      // For now, we can't determine this without source analysis
      // but we could enhance this later
      return type;
    }

    return type;
  }

  String _fixSelfReferencingTypeWithSource(
    String type,
    String originalClassName,
    String targetClassName,
    String fieldName,
    String source,
  ) {
    // Handle InvalidType by checking source for nullability
    if (type.contains('InvalidType')) {
      // Look for the field declaration in source to determine nullability
      var fieldPattern = RegExp(
        targetClassName.replaceAll('\$', '') + r'\?\s+get\s+' + RegExp.escape(fieldName),
        multiLine: true,
      );
      
      var nullableMatch = fieldPattern.firstMatch(source);
      if (nullableMatch != null) {
        // Field is nullable in source
        return type.replaceAll('InvalidType', targetClassName + '?');
      } else {
        // Check for non-nullable version
        var nonNullablePattern = RegExp(
          targetClassName.replaceAll('\$', '') + r'\s+get\s+' + RegExp.escape(fieldName),
          multiLine: true,
        );
        if (nonNullablePattern.firstMatch(source) != null) {
          return type.replaceAll('InvalidType', targetClassName);
        }
      }
      
      // Fallback: just replace InvalidType
      return type.replaceAll('InvalidType', targetClassName);
    }

    // Use the regular fix for other cases
    return _fixSelfReferencingType(type, originalClassName, targetClassName);
  }
}
