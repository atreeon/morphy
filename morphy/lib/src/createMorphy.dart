import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';
import 'package:morphy/src/helpers.dart';

import 'method_generator.dart';
import 'factory_method.dart';

String createMorphy(
  bool isAbstract,
  List<NameTypeClassComment> allFields,
  String className,
  String classComment,
  List<Interface> interfacesFromImplements,
  List<Interface> interfacesAllInclSubInterfaces,
  List<NameTypeClassComment> classGenerics,
  bool hasConstContructor,
  bool generateJson,
  bool hidePublicConstructor,
  List<Interface> explicitForJson,
  bool nonSealed,
  bool explicitToJson,
  bool generateCompareTo,
  bool generateCopyWithFn,
  List<FactoryMethodInfo> factoryMethods,
) {
  //recursively go through otherClasses and get my fieldnames &

  var sb = StringBuffer();
  var classNameTrimmed = className.replaceAll("\$", "");

  sb.write(getClassComment(interfacesFromImplements, classComment));

  if (generateJson) {
    sb.writeln(createJsonSingleton(classNameTrimmed, classGenerics));
    sb.writeln(
      createJsonHeader(
        className,
        classGenerics,
        hidePublicConstructor,
        explicitToJson,
        generateCompareTo,
      ),
    );
  }

  sb.write(
    getClassDefinition(
      isAbstract: isAbstract,
      nonSealed: nonSealed,
      className: className,
    ),
  );

  if (classGenerics.isNotEmpty) {
    sb.write(getClassGenerics(classGenerics));
  }

  // Handle extends and implements
  if (!isAbstract || (isAbstract && nonSealed)) {
    // For concrete classes or non-sealed abstract classes ($-prefixed)
    // If factory methods exist, implement instead of extend
    if (factoryMethods.isNotEmpty) {
      // Consolidate the main class and interfaces into single implements clause
      var mainClassName = className;
      if (classGenerics.isNotEmpty) {
        // For implements clause, use generic type parameters without bounds
        var typeParams = classGenerics.map((g) => g.name).join(', ');
        mainClassName += '<$typeParams>';
      }
      var allImplements = <String>[
        mainClassName,
      ]; // Keep the original $ClassName with generics
      if (interfacesFromImplements.isNotEmpty) {
        allImplements.addAll(
          interfacesFromImplements.map((e) {
            var type = e.interfaceName.replaceAll("\$", "");
            if (e.typeParams.isEmpty) {
              return type;
            }
            return "${type}<${e.typeParams.map((e) => e.type).join(", ")}>";
          }),
        );
      }
      sb.write(" implements ${allImplements.join(', ')}");
    } else {
      sb.write(" extends ${className}");
      if (classGenerics.isNotEmpty) {
        sb.write(getExtendsGenerics(classGenerics));
      }
      if (interfacesFromImplements.isNotEmpty) {
        sb.write(getImplements(interfacesFromImplements, className));
      }
    }
  } else {
    // For sealed abstract classes, only add implements for interfaces
    if (interfacesFromImplements.isNotEmpty) {
      sb.write(getImplements(interfacesFromImplements, className));
    }
  }

  sb.writeln(" {");
  if (isAbstract) {
    sb.writeln(getPropertiesAbstract(allFields));

    // Add abstract copyWith methods for sealed classes
    var selfInterface = Interface.fromGenerics(
      className,
      classGenerics.map((e) => NameType(e.name, e.type)).toList(),
      allFields,
    );
    sb.writeln(
      MethodGenerator.generateAbstractCopyWithMethods(
        interfaceFields: selfInterface.fields,
        interfaceName: selfInterface.interfaceName,
        interfaceGenerics: selfInterface.typeParams,
        generateCopyWithFn: generateCopyWithFn,
      ),
    );
  } else {
    sb.writeln(getProperties(allFields));
    sb.write(getClassComment(interfacesFromImplements, classComment));

    //constructor
    // var constructorName = getConstructorName(classNameTrimmed, hidePublicConstructor);
    if (allFields.isEmpty) {
      if (!hidePublicConstructor) {
        sb.writeln("${classNameTrimmed}();");
        sb.writeln('\n');
      }
      sb.writeln("${classNameTrimmed}._();");
    } else {
      //public constructor
      if (!hidePublicConstructor) {
        sb.writeln("${classNameTrimmed}({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("}) ${getInitializer(allFields)};");
      }

      //the json needs a public constructor, we add this if public constructor is hidden
      if (hidePublicConstructor && generateJson) {
        sb.writeln("${classNameTrimmed}.forJsonDoNotUse({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("}) ${getInitializer(allFields)};");
      }

      //we always want to write a private constructor (just a duplicate)
      sb.writeln("${classNameTrimmed}._({");
      sb.writeln(getConstructorRows(allFields));
      sb.writeln("}) ${getInitializer(allFields)};");
      sb.writeln('\n');

      if (hasConstContructor) {
        sb.writeln("const ${classNameTrimmed}.constant({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("}) ${getInitializer(allFields)};");
        sb.writeln('\n');
      }

      // Generate factory methods
      for (var factory in factoryMethods) {
        sb.writeln(generateFactoryMethod(factory, classNameTrimmed, allFields));
      }

      sb.writeln(getToString(allFields, classNameTrimmed));
    }

    sb.writeln('\n');
    sb.writeln(getHashCode(allFields));
    sb.writeln('\n');
    sb.writeln(getEquals(allFields, classNameTrimmed));
    sb.writeln('\n');
  }
  //
  var interfacesX = [
    ...interfacesAllInclSubInterfaces,
    Interface.fromGenerics(
      className,
      classGenerics.map((e) => NameType(e.name, e.type)).toList(),
      allFields,
    ),
  ];

  // Create list of known Morphy classes early so it can be used in method generators
  var knownClasses = [
    ...interfacesAllInclSubInterfaces.map(
      (i) => i.interfaceName.replaceAll("\$", ""),
    ),
    classNameTrimmed,
  ].toSet().toList();

  if (!isAbstract) {
    interfacesX.where((element) => !element.isExplicitSubType).forEach((x) {
      sb.writeln(
        MethodGenerator.generateCopyWithMethods(
          classFields: allFields,
          interfaceFields: x.fields,
          interfaceName: x.interfaceName,
          className: className,
          isClassAbstract: isAbstract,
          interfaceGenerics: x.typeParams,
          generateCopyWithFn: generateCopyWithFn,
          knownClasses: knownClasses,
        ),
      );
      // Generate changeTo methods for inherited interfaces (upward conversion: child to parent)
      if (x.interfaceName != classNameTrimmed) {
        sb.writeln(
          MethodGenerator.generateChangeToMethods(
            classFields: allFields,
            interfaceFields: x.fields,
            interfaceName: x.interfaceName,
            className: className,
            isClassAbstract: isAbstract,
            interfaceGenerics: x.typeParams,
            knownClasses: knownClasses,
            isInterfaceSealed: x.isSealed,
          ),
        );
      }
    });
  }

  if (generateJson) {
    // sb.writeln("// $classGenerics");
    // sb.writeln("//interfacesX");
    // sb.writeln("//explicitForJson");
    sb.writeln(commentEveryLine(interfacesX.map((e) => e.toString()).join()));
    sb.writeln(commentEveryLine(explicitForJson.join("\n").toString()));
    sb.writeln(generateFromJsonHeader(className));
    sb.writeln(generateFromJsonBody(className, classGenerics, explicitForJson));
    sb.writeln(generateToJson(className, classGenerics));
    sb.writeln(generateToJsonLean(className));
  }
  sb.writeln("}");
  if (!isAbstract && !className.startsWith('\$\$') && generateCompareTo) {
    // Create a list of all known classes from the interfaces

    sb.writeln(
      generateCompareExtension(
        isAbstract,
        className,
        classNameTrimmed,
        allFields,
        interfacesAllInclSubInterfaces, // Pass all known interfaces
        knownClasses, // Pass all known classes
        generateCompareTo,
      ),
    );
  }
  // Generate changeTo methods for explicitSubTypes (downward conversion: parent to child)
  if (interfacesX.any((element) => element.isExplicitSubType)) {
    sb.writeln(
      "extension ${classNameTrimmed}ChangeToE on ${classNameTrimmed} {",
    );

    interfacesX.where((element) => element.isExplicitSubType).forEach((x) {
      sb.writeln(
        MethodGenerator.generateChangeToMethods(
          classFields: allFields,
          interfaceFields: x.fields,
          interfaceName: x.interfaceName,
          className: className,
          isClassAbstract: isAbstract,
          interfaceGenerics: x.typeParams,
          knownClasses: knownClasses,
          isInterfaceSealed: x.isSealed,
        ),
      );
    });
    sb.writeln("}");
  }

  sb.writeln(getEnumPropertyList(allFields, className));

  sb.writeln(
    getPatchClass(
      allFields,
      className,
      knownClasses,
      classGenerics.map((e) => e.name).toList(),
    ),
  );
  // return commentEveryLine(sb.toString());
  return sb.toString();
}

String generateFactoryMethod(
  FactoryMethodInfo factory,
  String classNameTrimmed,
  List<NameTypeClassComment> allFields,
) {
  var sb = StringBuffer();

  // Generate factory method signature
  sb.write("  factory ${classNameTrimmed}.${factory.name}(");

  if (factory.parameters.isNotEmpty) {
    if (factory.parameters.any((p) => p.isNamed)) {
      sb.write("{");
      sb.write(
        factory.parameters
            .map((p) {
              var prefix = p.isRequired ? "required " : "";
              var suffix = p.hasDefaultValue && p.defaultValue != null
                  ? " = ${p.defaultValue}"
                  : "";
              var cleanType = p.type.replaceAll('\$', '');
              return "${prefix}${cleanType} ${p.name}${suffix}";
            })
            .join(", "),
      );
      sb.write("}");
    } else {
      sb.write(
        factory.parameters
            .map((p) {
              var suffix = p.hasDefaultValue && p.defaultValue != null
                  ? " = ${p.defaultValue}"
                  : "";
              var cleanType = p.type.replaceAll('\$', '');
              return "${cleanType} ${p.name}${suffix}";
            })
            .join(", "),
      );
    }
  }

  sb.write(") => ");

  // Generate simple factory body - transform $ClassName to ClassName
  var bodyCode = factory.bodyCode;
  if (bodyCode.contains('return ') && bodyCode.endsWith(';')) {
    // Remove 'return ' and trailing ';' for arrow function
    bodyCode = bodyCode.substring(7, bodyCode.length - 1);
  }

  // Transform the body to use the correct constructor name
  bodyCode = bodyCode
      .replaceAll(
        '${factory.className.replaceAll('\$', '')}._',
        '${classNameTrimmed}._',
      )
      .replaceAll('\$', '');

  sb.writeln("${bodyCode};");
  sb.writeln();

  return sb.toString();
}
