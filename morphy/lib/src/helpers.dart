//import 'package:analyzer_models/analyzer_models.dart';
import 'package:dartx/dartx.dart';
import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';
// import 'package:meta/meta.dart';

String getClassComment(List<Interface> interfaces, String classComment) {
  var a = interfaces
      .where((e) => e is InterfaceWithComment && e.comment != classComment) //
      .map((e) {
    var interfaceComment = e is InterfaceWithComment && e.comment != null //
        ? "\n${e.comment}"
        : "";
    return "///implements [${e.interfaceName}]\n///\n$interfaceComment\n///";
  }).toList();

  a.insert(0, classComment + "\n///");

  return a.join("\n").trim() + "\n";
}

/// remove dollars from the property type allowing for functions where
/// the dollars need to remain
String removeDollarsFromPropertyType(String propertyType) {
  var regex = RegExp("Function\((.*)\)");
  var result = regex.allMatches(propertyType);

  if (result.isNotEmpty) {
    return propertyType;
  }

  return propertyType.replaceAll(RegExp(r"(?<!<)(?<!<\$)\$\$?"), "");
}

List<NameTypeClassComment> getDistinctFields(
  List<NameTypeClassComment> fieldsRaw,
  List<InterfaceWithComment> interfaces,
) {
  var fields = fieldsRaw.map((f) => NameTypeClassComment(
      f.name, f.type, f.className?.replaceAll("\$", ""),
      comment: f.comment));

  var interfaces2 = interfaces //
      .map((x) => Interface.fromGenerics(
            x.interfaceName.replaceAll("\$", ""),
            x.typeParams,
            x.fields,
          ))
      .toList();
//
//    return Interface2(interface.type.replaceAll("\$", ""), result);
//  }).toList();

  var sortedFields =
      fields.sortedBy((element) => element.className ?? "").toList();
  var distinctFields =
      sortedFields.distinctBy((element) => element.name).toList();

  var adjustedFields = distinctFields.map((classField) {
    var i = interfaces2
        .where((x) => x.interfaceName == classField.className)
        .take(1)
        .toList();
    if (i.length > 0) {
      var paramNameType = i[0]
          .typeParams
          .where((interfaceGeneric) => //
              interfaceGeneric.name == classField.type)
          .toList();
      if (paramNameType.length > 0) {
        var name = removeDollarsFromPropertyType(paramNameType[0].type!);
        return NameTypeClassComment(classField.name, name, null,
            comment: classField.comment);
      }
    }

    var type = removeDollarsFromPropertyType(classField.type!);
    return NameTypeClassComment(classField.name, type, null,
        comment: classField.comment);
  }).toList();

  return adjustedFields;
}

String getClassDefinition(
    {required bool isAbstract,
    required bool nonSealed,
    required String className}) {
  var _className = className.replaceAll("\$", "");

  var abstract = isAbstract ? (nonSealed ? "abstract " : "sealed ") : "";

  return "${abstract}class $_className";
}

String getClassGenerics(List<NameType> generics) {
  if (generics.isEmpty) {
    return "";
  }

  var _generics = generics.map((e) {
    if (e.type == null) {
      return e.name;
    }

    return "${e.name} extends ${e.type}";
  }).joinToString(separator: ", ");

  return "<$_generics>";
}

String getExtendsGenerics(List<NameType> generics) {
  if (generics.isEmpty) {
    return "";
  }

  var _generics = generics //
      .map((e) => e.name)
      .joinToString(separator: ", ");

  return "<$_generics>";
}

String getImplements(List<Interface> interfaces, String className) {
  if (interfaces.isEmpty) {
    return "";
  }

  var types = interfaces.map((e) {
    var type = e.interfaceName.replaceAll("\$", "");

    if (e.typeParams.isEmpty) {
      return type;
    }

    return "${type}<${e.typeParams.map((e) => e.type).joinToString(separator: ", ")}>";
  }).joinToString(separator: ", ");

  return " implements $types";
}

String getEnumPropertyList(
    List<NameTypeClassComment> fields, String className) {
  if (fields.isEmpty) //
    return '';

  var first = "enum ${className.replaceAll("\$", "")}\$ {";
  var last = fields.map((e) => //
      e.name.startsWith("_") ? e.name.substring(1) : e.name).join(",") + "}";
  return first + last;
}

/// remove dollars from the dataType except for function types
String getDataTypeWithoutDollars(String type) {
  var regex = RegExp("Function\((.*)\)");
  var result = regex.allMatches(type);

  if (result.isNotEmpty) {
    return type;
  }

  return type.replaceAll("\$", "");
}

String getProperties(List<NameTypeClassComment> fields) {
  return fields.map((e) {
    var line = "final ${getDataTypeWithoutDollars(e.type ?? "")} ${e.name};";
    var result = e.comment == null ? line : "${e.comment}\n$line";
    return result;
  }).join("\n");
}

String getPropertiesAbstract(List<NameTypeClassComment> fields) => //
    fields
        .map((e) => //
            e.comment == null
                ? "${getDataTypeWithoutDollars(e.type ?? "")} get ${e.name};" //
                : "${e.comment}\n${e.type} get ${e.name};")
        .join("\n");

String getConstructorRows(List<NameType> fields) => //
    fields
        .map((e) {
          var required =
              e.type!.substring(e.type!.length - 1) == "?" ? "" : "required ";
          var thisOrType = e.name.startsWith("_") ? "${e.type} " : "this.";
          var propertyName = e.name[0] == '_' ? e.name.substring(1) : e.name;
          return "$required$thisOrType$propertyName,";
        })
        .join("\n")
        .trim();

String getInitializer(List<NameType> fields) {
  var result = fields
      .where((e) => e.name.startsWith('_'))
      .map((e) {
        return "${e.name} = ${e.name.substring(1)}";
      })
      .join(",")
      .trim();

  var result2 = result.length > 0 ? " : $result" : "";
  return result2;
}

String getToString(List<NameType> fields, String className) {
  if (fields.isEmpty) {
    return """__String toString() => "($className-)""";
  }

  var items = fields
      .map((e) => "${e.name}:\${${e.name}.toString()}")
      .joinToString(separator: "|");
  return """__String toString() => "($className-$items)";""";
}

String getHashCode(List<NameType> fields) {
  if (fields.isEmpty) {
    return "";
  }

  var items =
      fields.map((e) => "${e.name}.hashCode").joinToString(separator: ", ");
  return """__int get hashCode => __hashObjects([$items]);""";
}

String getEquals(List<NameType> fields, String className) {
  var sb = StringBuffer();

  sb.write(
      "__bool operator ==(__Object other) => __identical(this, other) || other is $className && runtimeType == other.runtimeType");

  sb.writeln(fields.isEmpty ? "" : " &&");

  sb.write(fields.map((e) {
    if ((e.type!.characters.take(5).string == "List<" ||
        e.type!.characters.take(4).string == "Set<")) {
      //todo: hack here, a nullable entry won't compare properly to an empty list
      if (e.type!.characters.last == "?") {
        return "(${e.name}??[]).equalUnorderedD(other.${e.name}??[])";
      } else {
        return "(${e.name}).equalUnorderedD(other.${e.name})";
      }
    }

    return "${e.name} == other.${e.name}";
  }).joinToString(separator: " && "));

  sb.write(";");

  return sb.toString();
}

String createJsonHeader(String className, List<NameType> classGenerics,
    bool privateConstructor, bool explicitToJson) {
  var sb = StringBuffer();

  if (!className.startsWith("\$\$")) {
    var jsonConstructorName =
        privateConstructor ? "constructor: 'forJsonDoNotUse'" : "";

    if (classGenerics.length > 0) //
      sb.writeln(
          "@JsonSerializable(explicitToJson: $explicitToJson, genericArgumentFactories: true, $jsonConstructorName)");
    else
      sb.writeln(
          "@JsonSerializable(explicitToJson: $explicitToJson, $jsonConstructorName)");
  }

  return sb.toString();
}

///[classFields] & [interfaceFields] should be renamed
/// for changeTo [classFields] and [className] is what we are copying from
/// and [interfaceFields] and [interfaceName] is what we are copying to
/// [classFields] can be an interface & [interfaceFields] can be a class!
String getCopyWith({
  required List<NameType> classFields,
  required List<NameType> interfaceFields,
  required String interfaceName,
  required String className,
  required bool isClassAbstract,
  required List<NameType> interfaceGenerics,
  bool isExplicitSubType =
      false, //for where we specify the explicit subtypes for changeTo
}) {
  var sb = StringBuffer();

  var classNameTrimmed = className.replaceAll("\$", "");
  var interfaceNameTrimmed = interfaceName.replaceAll("\$", "");

  // var interfaceGenericString = interfaceGenerics //
  //     .map((e) => e.type == null //
  //         ? e.name
  //         : "${e.name} extends ${e.type}")
  //     .joinToString(separator: ", ");

  var interfaceGenericStringWithExtends = interfaceGenerics //
      .map((e) => e.type == null //
          ? e.name
          : "${e.name} extends ${e.type}")
      .joinToString(separator: ", ");

  if (interfaceGenericStringWithExtends.length > 0) {
    interfaceGenericStringWithExtends = "<$interfaceGenericStringWithExtends>";
  }

  var interfaceGenericStringNoExtends = interfaceGenerics //
      .map((e) => e.name)
      .joinToString(separator: ", ");

  if (interfaceGenericStringNoExtends.length > 0) {
    interfaceGenericStringNoExtends = "<$interfaceGenericStringNoExtends>";
  }

  isExplicitSubType //
      ? sb.write(
          "$interfaceNameTrimmed$interfaceGenericStringNoExtends changeTo$interfaceNameTrimmed$interfaceGenericStringWithExtends")
      : sb.write(
          "$interfaceNameTrimmed$interfaceGenericStringNoExtends copyWith$interfaceNameTrimmed$interfaceGenericStringWithExtends");

  // if (interfaceGenerics.isNotEmpty) {
  //   var generic = interfaceGenerics //
  //       .map((e) => e.type == null //
  //           ? e.name
  //           : "${e.name} extends ${e.type}")
  //       .joinToString(separator: ", ");
  //   sb.write("<$generic>");
  // }

  sb.write("(");

  //where property name of interface is the same as the one in the class
  //use the type of the class

  var fieldsForSignature = classFields //
      .where((element) =>
          interfaceFields.map((e) => e.name).contains(element.name));

  // identify fields in the interface not in the class
  var requiredFields = isExplicitSubType //
      ? interfaceFields //
          .where((x) => classFields.none((cf) => cf.name == x.name))
          .toList()
      : <NameType>[];

  if (fieldsForSignature.isNotEmpty || requiredFields.isNotEmpty) //
    sb.write("{");

  sb.writeln();

  sb.write(requiredFields.map((e) {
    var interfaceType =
        interfaceFields.firstWhere((element) => element.name == e.name).type;
    return "required ${getDataTypeWithoutDollars(interfaceType!)} ${e.name},\n";
  }).join());

  sb.write(fieldsForSignature.map((e) {
    var interfaceType = interfaceFields
        .firstWhere(
          (element) => element.name == e.name,
        )
        .type;

    var name = e.name.startsWith("_") ? e.name.substring(1) : e.name;

    return "${getDataTypeWithoutDollars(interfaceType!)} Function()? $name,\n";
  }).join());

  if (fieldsForSignature.isNotEmpty || requiredFields.isNotEmpty) //
    sb.write("}");

  if (isClassAbstract && !isExplicitSubType) {
    sb.write(");");
    return sb.toString();
  }

  sb.writeln(") {");

  if (isExplicitSubType) {
    sb.writeln("return ${getDataTypeWithoutDollars(interfaceName)}._(");
  } else {
    sb.writeln("return $classNameTrimmed._(");
  }

  sb.write(requiredFields //
      .map((e) {
    var name = e.name.startsWith("_") ? e.name.substring(1) : e.name;
    var classType = getDataTypeWithoutDollars(e.type!);
    return "$name: $name as $classType,\n";
  }).join());

  sb.write(fieldsForSignature //
      .map((e) {
    var name = e.name.startsWith("_") ? e.name.substring(1) : e.name;

    var classType = getDataTypeWithoutDollars(
        classFields.firstWhere((element) => element.name == e.name).type!);
    return "$name: $name == null ? this.${e.name} as $classType : $name() as $classType,\n";
  }).join());

  var fieldsNotInSignature = classFields //
      .where((element) =>
          !interfaceFields.map((e) => e.name).contains(element.name));

  sb.write(fieldsNotInSignature //
      .map((e) =>
          "${e.name.startsWith('_') ? e.name.substring(1) : e.name}: (this as $classNameTrimmed).${e.name},\n")
      .join());

  sb.write(") as $interfaceNameTrimmed$interfaceGenericStringNoExtends;");

  // if (isExplicitSubType) {
  //   sb.write(") as $interfaceNameTrimmed;");
  // } else {
  //   sb.write(") as $interfaceNameTrimmed$interfaceGenericStringNoExtends;");
  // }
  sb.write("}");

  return sb.toString();
}

//String getCopyWithSignature(List<NameType> fields, String trimmedClassName) {
//  var paramList = "\n" + fields.map((e) => "required ${e.type} ${e.name}").joinToString(separator: ",\n") + ",\n";
//  return "$trimmedClassName cw$trimmedClassName({$paramList}) {";
//}

//List<Interface> getValueTImplements(List<Interface> interfaces, String trimmedClassName, List<NameType> fields) {
//  return [
//    ...interfaces //
//        .where((element) => element.type.startsWith("\$"))
//        .toList(),
//    Interface(trimmedClassName, typeArgsTypes, fields)
//  ];
//}

//class Interface2 {
//  final String type;
//  final List<NameType> paramNameType;
//
//  Interface2(this.type, this.paramNameType);
//
//  toString() => "${this.type}|${this.paramNameType}";
//}

String getConstructorName(String trimmedClassName, bool hasCustomConstructor) {
  return hasCustomConstructor //
      ? "$trimmedClassName._"
      : trimmedClassName;
}

String generateFromJsonHeader(String className) {
  var _className = "${className.replaceFirst("\$", "")}";

  return "factory ${_className.replaceFirst("\$", "")}.fromJson(__Map<__String, dynamic> json) {";
}

String generateFromJsonBody(
    String className, List<NameType> generics, List<Interface> interfaces) {
  var _class = Interface(className, generics.map((e) => e.type ?? "").toList(),
      generics.map((e) => e.name).toList(), []);
  var _classes = [...interfaces, _class];

  var body = _classes //
      .where((c) => !c.interfaceName.startsWith("\$\$"))
      .mapIndexed((i, c) {
    var _interfaceName = "${c.interfaceName.replaceFirst("\$", "")}";
    var start = i == 0 ? "if" : "} else if";
    var genericTypes = c.typeParams.map((e) => "'_${e.name}_'").join(",");
    // var types = c.typeParams.length == 0 ? "" : "<${c.typeParams.map((t) => "dynamic").join(', ')}>";

    if (c.typeParams.length > 0) {
      return """$start (json['_className_'] == "$_interfaceName") {
      var fn_fromJson = getFromJsonToGenericFn(
        ${_interfaceName}_Generics_Sing().fns,
        json,
        [$genericTypes],
      );
      return fn_fromJson(json);
""";
    } else {
      return """$start (json['_className_'] == "$_interfaceName") {
    return _\$${_interfaceName}FromJson(json, );
""";
    }
  }).join("\n");

  var _className = className.replaceFirst("\$", "").replaceFirst("\$", "");

  var end = """    } else {
      throw UnsupportedError("The _className_ '\${json['_className_']}' is not supported by the ${_className}.fromJson constructor.");
    }
  }
""";

  return body + end;
}

String generateToJson(String className, List<NameType> generics) {
  if (className.startsWith("\$\$")) {
    return "__Map<__String, dynamic> toJsonCustom([__Map<__Type, __Object? Function(__Never)>? fns]);";
  }

  var _className = "${className.replaceFirst("\$", "")}";

  var getGenericFn = generics //
      .map((e) => "    var fn_${e.name} = getGenericToJsonFn(_fns, ${e.name});")
      .join("\n");

  var toJsonParams = generics //
      .map((e) => "      fn_${e.name} as __Object? Function(${e.name})")
      .join(",\n");

  var recordType = generics //
      .map((e) => "    data['_${e.name}_'] = ${e.name}.toString();")
      .join("\n");

  var result = """
  // ignore: unused_field
  __Map<__Type, __Object? Function(__Never)> _fns = {};

  __Map<__String, dynamic> toJsonCustom([__Map<__Type, __Object? Function(__Never)>? fns]){
    _fns = fns ?? {};
    return toJson();
  }

  __Map<__String, dynamic> toJson() {
$getGenericFn
    final __Map<__String, dynamic> data = _\$${_className}ToJson(this,
$toJsonParams);
    // Adding custom key-value pair
    data['_className_'] = '$_className';
$recordType

    return data;
  }""";

  return result;
}

String createJsonSingleton(String classNameTrim, List<NameType> generics) {
  if (generics.length == 0) //
    return "";

  var objects = generics.map((e) => "__Object").join(", ");

  var result = """
class ${classNameTrim}_Generics_Sing {
  __Map<__List<__String>, $classNameTrim<${objects}> Function(__Map<__String, dynamic>)> fns = {};

  factory ${classNameTrim}_Generics_Sing() => _singleton;
  static final ${classNameTrim}_Generics_Sing _singleton = ${classNameTrim}_Generics_Sing._internal();

  ${classNameTrim}_Generics_Sing._internal() {}
}
    """;

  return result;
}

String generateFromJsonLeanHeader(String className) {
  var _className = "${className.replaceFirst("\$", "")}";

  return "factory ${_className.replaceFirst("\$", "")}.fromJsonLean(__Map<__String, dynamic> json) {";
}

String generateFromJsonLeanBody(String className) {
  var _className = className.replaceFirst("\$", "").replaceFirst("\$", "");
  return """
    return _\$${_className}FromJson(json, );
  }
""";
}

String generateToJsonLean(String className) {
  if (className.startsWith("\$\$")) {
    return "";
  }

  var _className = "${className.replaceFirst("\$", "")}";
  var result = """

  __Map<__String, dynamic> toJsonLean() {
    final __Map<__String, dynamic> data = _\$${_className}ToJson(this,);
    return data;
  }""";

  return result;
}
