import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';
import 'package:morphy/src/helpers.dart';

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
) {
  //recursively go through otherClasses and get my fieldnames &

  var sb = StringBuffer();
  var classNameTrim = className.replaceAll("\$", "");

  sb.write(getClassComment(interfacesFromImplements, classComment));

  //move this into a helper class!
  if (generateJson) {
    sb.writeln(createJsonSingleton(classNameTrim, classGenerics));
    sb.writeln(createJsonHeader(className, classGenerics, hidePublicConstructor, explicitToJson));
  }

  sb.write(getClassDefinition(isAbstract: isAbstract, nonSealed: nonSealed, className: className));

  if (classGenerics.isNotEmpty) {
    sb.write(getClassGenerics(classGenerics));
  }

  sb.write(" extends ${className}");

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
    // var constructorName = getConstructorName(classNameTrim, hidePublicConstructor);
    if (allFields.isEmpty) {
      if (!hidePublicConstructor) {
        sb.writeln("${classNameTrim}();");
      }
      sb.writeln("${classNameTrim}._();");
    } else {
      //public constructor
      if (!hidePublicConstructor) {
        sb.writeln("${classNameTrim}({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("}) ${getInitialiser(allFields)};");
      }

      //the json needs a public constructor, we add this if public constructor is hidden
      if (hidePublicConstructor && generateJson) {
        sb.writeln("${classNameTrim}.forJsonDoNotUse({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("}) ${getInitialiser(allFields)};");
      }

      //we always want to write a private constructor (just a duplicate)
      sb.writeln("${classNameTrim}._({");
      sb.writeln(getConstructorRows(allFields));
      sb.writeln("}) ${getInitialiser(allFields)};");

      if (hasConstContructor) {
        sb.writeln("const ${classNameTrim}.constant({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("}) ${getInitialiser(allFields)};");
      }
      sb.writeln(getToString(allFields, classNameTrim));
    }

    sb.writeln(getHashCode(allFields));
    sb.writeln(getEquals(allFields, classNameTrim));
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
    sb.writeln(
      getCopyWith(
        classFields: allFields,
        interfaceFields: x.fields,
        interfaceName: x.interfaceName,
        className: className,
        isClassAbstract: isAbstract,
        interfaceGenerics: x.typeParams,
        isExplicitSubType: x.isExplicitSubType,
      ),
    );
  });

  if (generateJson) {
    // sb.writeln("// $classGenerics");
    // sb.writeln("//interfacesX");
    // sb.writeln("//explicitForJson");
    sb.writeln(commentEveryLine(interfacesX.map((e) => e.toString()).join()));
    sb.writeln(commentEveryLine(explicitForJson.join("\n").toString()));
    sb.writeln(generateFromJsonHeader(className));
    sb.writeln(generateFromJsonBody(className, classGenerics, explicitForJson));
    sb.writeln(generateToJson(className, classGenerics));
  }

  sb.writeln("}");

  sb.writeln();
  sb.writeln("extension ${className}_changeTo_E on ${className} {");

  if(!isAbstract){
    sb.writeln(
      getCopyWith(
        classFields: allFields,
        interfaceFields: allFields,
        interfaceName: className,
        className: className,
        isClassAbstract: isAbstract,
        interfaceGenerics: classGenerics,
        isExplicitSubType: true,
      ),
    );
  }

  interfacesX.where((element) => element.isExplicitSubType).forEach((x) {
    sb.writeln(
      getCopyWith(
        classFields: allFields,
        interfaceFields: x.fields,
        interfaceName: x.interfaceName,
        className: className,
        isClassAbstract: isAbstract,
        interfaceGenerics: x.typeParams,
        isExplicitSubType: x.isExplicitSubType,
      ),
    );
  });
  sb.writeln("}");

  sb.writeln(getEnumPropertyList(allFields, className));

  // return commentEveryLine(sb.toString());
  return sb.toString();
}

String commentEveryLine(String multilineString) {
  return multilineString.split('\n').map((line) => '//' + line).join('\n');
}
