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
  List<Interface> explicitForJson,
) {
  //recursively go through otherClasses and get my fieldnames &

  var sb = StringBuffer();
  var classNameTrim = className.replaceAll("\$", "");

  sb.write(getClassComment(interfacesFromImplements, classComment));

  if (generateJson) {
    sb.writeln(createJsonSingleton(classNameTrim, classGenerics));
    // sb.writeln("Map<String, dynamic Function(Object? json)> jsonToGenericFunctions_$classNameTrim = {};");
    if (classGenerics.length > 0) //
      sb.writeln("@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)");
    else
      sb.writeln("@JsonSerializable(explicitToJson: true)");
  }

  sb.write(getClassDefinition(isAbstract, className));

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
  var constructorName = getConstructorName(classNameTrim);
  if (isAbstract) {
    sb.writeln(getPropertiesAbstract(allFields));
  } else {
    sb.writeln(getProperties(allFields));
    sb.write(getClassComment(interfacesFromImplements, classComment));

    if (allFields.isEmpty) {
      sb.writeln("${constructorName}();");
    } else {
      sb.writeln("${constructorName}({");
      sb.writeln(getConstructorRows(allFields));
      sb.writeln("});");

      if (hasConstContructor) {
        sb.writeln("const ${constructorName}.constant({");
        sb.writeln(getConstructorRows(allFields));
        sb.writeln("});");
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
