import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';
import 'package:morphy/src/helpers.dart';

import 'method_generator.dart';

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
) {
  //recursively go through otherClasses and get my fieldnames &

  var sb = StringBuffer();
  var classNameTrimmed = className.replaceAll("\$", "");

  sb.write(getClassComment(interfacesFromImplements, classComment));

  if (generateJson) {
    sb.writeln(createJsonSingleton(classNameTrimmed, classGenerics));
    sb.writeln(createJsonHeader(className, classGenerics, hidePublicConstructor,
        explicitToJson, generateCompareTo));
  }

  sb.write(getClassDefinition(
      isAbstract: isAbstract, nonSealed: nonSealed, className: className));

  if (classGenerics.isNotEmpty) {
    sb.write(getClassGenerics(classGenerics));
  }

  // Handle extends and implements
  if (!isAbstract || (isAbstract && nonSealed)) {
    // For concrete classes or non-sealed abstract classes ($-prefixed)
    sb.write(" extends ${className}");
  }

  if (classGenerics.isNotEmpty) {
    sb.write(getExtendsGenerics(classGenerics));
  }

  if (interfacesFromImplements.isNotEmpty) {
    sb.write(getImplements(interfacesFromImplements, className));
  }

  sb.writeln(" {");
  if (isAbstract) {
    sb.writeln(getPropertiesAbstract(allFields));
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

  interfacesX.where((element) => !element.isExplicitSubType).forEach((x) {
    // sb.writeln(
    //   getCopyWith(
    //     classFields: allFields,
    //     interfaceFields: x.fields,
    //     interfaceName: x.interfaceName,
    //     className: className,
    //     isClassAbstract: isAbstract,
    //     // interfaceGenerics: x.typeParams,
    //     isExplicitSubType: x.isExplicitSubType,
    //   ),
    // );
    sb.writeln(
      MethodGenerator.generateCopyWithMethods(
        classFields: allFields,
        interfaceFields: x.fields,
        interfaceName: x.interfaceName,
        className: className,
        isClassAbstract: isAbstract,
      ),
    );
  });

  // if (!isAbstract) {
  //   sb.writeln(
  //     MethodGenerator.generateCopyWithMethods(
  //       classFields: allFields,
  //       interfaceFields: allFields,
  //       interfaceName: className,
  //       className: className,
  //       isClassAbstract: isAbstract,
  //     ),
  //   );
  // }
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
    var knownClasses = [
      ...interfacesAllInclSubInterfaces
          .map((i) => i.interfaceName.replaceAll("\$", "")),
      classNameTrimmed,
    ].toSet().toList();

    sb.writeln(generateCompareExtension(
      isAbstract,
      className,
      classNameTrimmed,
      allFields,
      interfacesAllInclSubInterfaces, // Pass all known interfaces
      knownClasses, // Pass all known classes
      generateCompareTo,
    ));
  }

  sb.writeln("extension ${classNameTrimmed}ChangeToE on ${classNameTrimmed} {");

  if (!isAbstract) {
    // sb.writeln(
    //   getCopyWith(
    //     classFields: allFields,
    //     interfaceFields: allFields,
    //     interfaceName: className,
    //     className: className,
    //     isClassAbstract: isAbstract,
    //     // interfaceGenerics: classGenerics,
    //     isExplicitSubType: true,
    //   ),
    // );
    //
  }

  interfacesX.where((element) => element.isExplicitSubType).forEach((x) {
    sb.writeln(
      MethodGenerator.generateChangeToMethods(
        classFields: allFields,
        interfaceFields: x.fields,
        interfaceName: x.interfaceName,
        className: className,
        isClassAbstract: isAbstract,
      ),
    );
  });
  sb.writeln("}");

  sb.writeln(getEnumPropertyList(allFields, className));

  // return commentEveryLine(sb.toString());
  return sb.toString();
}
