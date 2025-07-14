//import 'package:analyzer_models/analyzer_models.dart';
import 'package:dartx/dartx.dart';
import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';

import 'method_generator.dart';

// import 'package:meta/meta.dart';
const List<String> PRIMITIVE_TYPES = [
  'String',
  'DateTime',
  'Duration',
  'bool',
  'int',
  'double',
  'num',
  'dynamic',
  'List<',
  'Map<',
  'Set<',
];

String getClassComment(List<Interface> interfaces, String classComment) {
  var a = interfaces
      .where((e) => e is InterfaceWithComment && e.comment != classComment) //
      .map((e) {
        var interfaceComment =
            e is InterfaceWithComment &&
                e.comment !=
                    null //
            ? "\n${e.comment}"
            : "";
        return "///implements [${e.interfaceName}]\n///\n$interfaceComment\n///";
      })
      .toList();

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
  var fields = fieldsRaw.map(
    (f) => NameTypeClassComment(
      f.name,
      f.type,
      f.className?.replaceAll("\$", ""),
      comment: f.comment,
      isEnum: f.isEnum,
    ),
  );

  var interfaces2 =
      interfaces //
          .map(
            (x) => Interface.fromGenerics(
              x.interfaceName.replaceAll("\$", ""),
              x.typeParams,
              x.fields,
            ),
          )
          .toList();
  //
  //    return Interface2(interface.type.replaceAll("\$", ""), result);
  //  }).toList();

  var sortedFields = fields
      .sortedBy((element) => element.className ?? "")
      .toList();
  var distinctFields = sortedFields
      .distinctBy((element) => element.name)
      .toList();

  var adjustedFields = distinctFields.map((classField) {
    var i = interfaces2
        .where((x) => x.interfaceName == classField.className)
        .take(1)
        .toList();
    if (i.length > 0) {
      var paramNameType = i[0].typeParams
          .where(
            (interfaceGeneric) => //
                interfaceGeneric.name == classField.type,
          )
          .toList();
      if (paramNameType.length > 0) {
        var name = removeDollarsFromPropertyType(paramNameType[0].type!);
        return NameTypeClassComment(
          classField.name,
          name,
          null,
          comment: classField.comment,
          isEnum: classField.isEnum,
        );
      }
    }

    var type = removeDollarsFromPropertyType(classField.type!);
    return NameTypeClassComment(
      classField.name,
      type,
      null,
      comment: classField.comment,
      isEnum: classField.isEnum,
    );
  }).toList();

  return adjustedFields;
}

String getClassDefinition({
  required bool isAbstract,
  required bool nonSealed,
  required String className,
}) {
  var _className = className.replaceAll("\$", "");

  if (isAbstract) {
    if (!nonSealed) {
      // Just generate a sealed class for $$-prefixed classes
      return "sealed class $_className";
    }
    return "abstract class $_className";
  }

  return "class $_className";
}

String getClassGenerics(List<NameType> generics) {
  if (generics.isEmpty) {
    return "";
  }

  var _generics = generics
      .map((e) {
        if (e.type == null) {
          return e.name;
        }

        return "${e.name} extends ${e.type}";
      })
      .joinToString(separator: ", ");

  return "<$_generics>";
}

String getExtendsGenerics(List<NameType> generics) {
  if (generics.isEmpty) {
    return "";
  }

  var _generics =
      generics //
          .map((e) => e.name)
          .joinToString(separator: ", ");

  return "<$_generics>";
}

String getImplements(List<Interface> interfaces, String className) {
  if (interfaces.isEmpty) {
    return "";
  }

  var types = interfaces
      .map((e) {
        var type = e.interfaceName.replaceAll("\$", "");

        if (e.typeParams.isEmpty) {
          return type;
        }

        return "${type}<${e.typeParams.map((e) => e.type).joinToString(separator: ", ")}>";
      })
      .joinToString(separator: ", ");

  return " implements $types";
}

String getEnumPropertyList(
  List<NameTypeClassComment> fields,
  String className,
) {
  if (fields.isEmpty) return '';

  String classNameTrimmed = '${className.replaceAll("\$", "")}';
  String enumName = '${classNameTrimmed}\$';

  var sb = StringBuffer();

  // Generate enum
  sb.writeln("enum $enumName {");
  sb.writeln(
    fields
        .map((e) => e.name.startsWith("_") ? e.name.substring(1) : e.name)
        .join(","),
  );
  sb.writeln("}\n");
  return sb.toString();
}

String getPatchClass(
  List<NameTypeClassComment> fields,
  String className,
  List<String> knownClasses, [
  List<String> genericTypeNames = const [],
]) {
  if (fields.isEmpty || className.startsWith('\$\$')) return '';

  String classNameTrimmed = '${className.replaceAll("\$", "")}';
  String enumName = '${classNameTrimmed}\$';

  var sb = StringBuffer();

  // Add Patch<T> implementation
  sb.writeln(
    "class ${classNameTrimmed}Patch implements Patch<$classNameTrimmed> {",
  );
  sb.writeln("  final Map<$enumName, dynamic> _patch = {};");
  sb.writeln();

  // Static factory methods
  sb.writeln(
    "  static ${classNameTrimmed}Patch create([Map<String, dynamic>? diff]) {",
  );
  sb.writeln("    final patch = ${classNameTrimmed}Patch();");
  sb.writeln("    if (diff != null) {");
  sb.writeln("      diff.forEach((key, value) {");
  sb.writeln("        try {");
  sb.writeln(
    "          final enumValue = $enumName.values.firstWhere((e) => e.name == key);",
  );
  sb.writeln("          if (value is Function) {");
  sb.writeln("            patch._patch[enumValue] = value();");
  sb.writeln("          } else {");
  sb.writeln("            patch._patch[enumValue] = value;");
  sb.writeln("          }");
  sb.writeln("        } catch (_) {}");
  sb.writeln("      });");
  sb.writeln("    }");
  sb.writeln("    return patch;");
  sb.writeln("  }");
  sb.writeln();

  // Generate fromPatch
  sb.writeln(
    "  static ${classNameTrimmed}Patch fromPatch(Map<${classNameTrimmed}\$, dynamic> patch) {",
  );
  sb.writeln("    final _patch = ${classNameTrimmed}Patch();");
  sb.writeln("    _patch._patch.addAll(patch);");
  sb.writeln("    return _patch;");
  sb.writeln("  }");
  sb.writeln();

  // Convert to map method
  sb.writeln("  Map<$enumName, dynamic> toPatch() => Map.from(_patch);");
  sb.writeln();

  sb.writeln("  $classNameTrimmed applyTo($classNameTrimmed entity) {");
  sb.writeln("    return entity.copyWith$classNameTrimmed(patchInput: this);");
  sb.writeln("  }");
  sb.writeln();

  // Add toJson method with _className_
  sb.writeln("  Map<String, dynamic> toJson() {");
  sb.writeln("    final json = <String, dynamic>{};");
  sb.writeln("    _patch.forEach((key, value) {");
  sb.writeln("      if (value != null) {");
  sb.writeln("        if (value is Function) {");
  sb.writeln("          final result = value();");
  sb.writeln("          json[key.name] = _convertToJson(result);");
  sb.writeln("        } else {");
  sb.writeln("          json[key.name] = _convertToJson(value);");
  sb.writeln("        }");
  sb.writeln("      }");
  sb.writeln("    });");
  sb.writeln("    return json;");
  sb.writeln("  }");
  sb.writeln();

  // Add convertToJson method
  sb.writeln("  dynamic _convertToJson(dynamic value) {");
  sb.writeln("    if (value == null) return null;");
  sb.writeln("    if (value is DateTime) return value.toIso8601String();");
  sb.writeln("    if (value is Enum) return value.toString().split('.').last;");
  sb.writeln(
    "    if (value is List) return value.map((e) => _convertToJson(e)).toList();",
  );
  sb.writeln(
    "    if (value is Map) return value.map((k, v) => MapEntry(k.toString(), _convertToJson(v)));",
  );
  sb.writeln(
    "    if (value is num || value is bool || value is String) return value;",
  );
  sb.writeln("""    try {
        if (value?.toJsonLean != null) return value.toJsonLean();
      } catch (_) {}"""); // Safely handle if toJsonLean doesn't exist

  // Fall back to toJson
  sb.writeln("    if (value?.toJson != null) return value.toJson();");

  sb.writeln("    return value.toString();");
  sb.writeln("  }");
  sb.writeln();

  // Add fromJson factory
  sb.writeln(
    "  static ${classNameTrimmed}Patch fromJson(Map<String, dynamic> json) {",
  );
  sb.writeln("    return create(json);");
  sb.writeln("  }");
  sb.writeln();

  // Generate with methods
  for (var field in fields) {
    var name = field.name.startsWith("_")
        ? field.name.substring(1)
        : field.name;
    var baseType = getDataTypeWithoutDollars(field.type ?? "dynamic");
    var capitalizedName =
        name.substring(0, 1).toUpperCase() + name.substring(1);

    // Make sure we don't add ? if it's already nullable
    var cleanBaseType = baseType.replaceAll("?", "");
    var isGenericType = genericTypeNames.contains(cleanBaseType);
    var parameterType = isGenericType
        ? 'dynamic'
        : (baseType.endsWith('?') ? baseType : baseType + '?');

    sb.writeln(
      "  ${classNameTrimmed}Patch with$capitalizedName($parameterType value) {",
    );
    sb.writeln("    _patch[$enumName.$name] = value;");
    sb.writeln("    return this;");
    sb.writeln("  }");
    sb.writeln();

    var patchType = getPatchType(field.type ?? "dynamic");
    var cleanPatchBaseType = baseType.replaceAll("?", "");
    var isPatchGenericType = genericTypeNames.contains(cleanPatchBaseType);
    if (!PRIMITIVE_TYPES.any(
          (primitiveType) => cleanPatchBaseType.startsWith(primitiveType),
        ) &&
        !field.isEnum &&
        !isPatchGenericType) {
      sb.writeln(
        "  ${classNameTrimmed}Patch with${capitalizedName}Patch(${patchType} value) {",
      );
      sb.writeln("    _patch[$enumName.$name] = value;");
      sb.writeln("    return this;");
      sb.writeln("  }");
      sb.writeln();
    }
  }

  sb.writeln("}");

  return sb.toString();
}

String getNormalType(String type) {
  bool isNullable = type.endsWith('?');
  String baseType = isNullable ? type.substring(0, type.length - 1) : type;
  return baseType + (isNullable ? '?' : '');
}

String getPatchType(String type) {
  bool isNullable = type.endsWith('?');
  String baseType = isNullable ? type.substring(0, type.length - 1) : type;
  return baseType + 'Patch' + (isNullable ? '?' : '');
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
  return fields
      .map((e) {
        var line =
            "final ${getDataTypeWithoutDollars(e.type ?? "")} ${e.name};";
        var result = e.comment == null ? line : "${e.comment}\n$line";
        return result;
      })
      .join("\n");
}

String getPropertiesAbstract(List<NameTypeClassComment> fields) => //
fields
    .map(
      (e) => //
      e.comment == null
          ? "${getDataTypeWithoutDollars(e.type ?? "")} get ${e.name};" //
          : "${e.comment}\n${e.type} get ${e.name};",
    )
    .join("\n");

String getConstructorRows(List<NameType> fields) => //
fields
    .map((e) {
      var required = e.type!.substring(e.type!.length - 1) == "?"
          ? ""
          : "required ";
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
    return """String toString() => "($className-)""";
  }

  var items = fields
      .map((e) => "${e.name}:\${${e.name}.toString()}")
      .joinToString(separator: "|");
  return """String toString() => "($className-$items)";""";
}

String getHashCode(List<NameType> fields) {
  if (fields.isEmpty) {
    return "";
  }

  var items = fields
      .map((e) => "${e.name}.hashCode")
      .joinToString(separator: ", ");
  return """int get hashCode => hashObjects([$items]);""";
}

String getEquals(List<NameType> fields, String className) {
  var sb = StringBuffer();

  sb.write(
    "bool operator ==(Object other) => identical(this, other) || other is $className && runtimeType == other.runtimeType",
  );

  sb.writeln(fields.isEmpty ? "" : " &&");

  sb.write(
    fields
        .map((e) {
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
        })
        .joinToString(separator: " && "),
  );

  sb.write(";");

  return sb.toString();
}

String createJsonHeader(
  String className,
  List<NameType> classGenerics,
  bool privateConstructor,
  bool explicitToJson,
  bool generateCompareTo,
) {
  var sb = StringBuffer();

  if (!className.startsWith("\$\$")) {
    var jsonConstructorName = privateConstructor
        ? "constructor: 'forJsonDoNotUse'"
        : "";

    if (classGenerics.length > 0) //
      sb.writeln(
        "@JsonSerializable(explicitToJson: $explicitToJson, genericArgumentFactories: true, $jsonConstructorName)",
      );
    else
      sb.writeln(
        "@JsonSerializable(explicitToJson: $explicitToJson, $jsonConstructorName)",
      );
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
  bool isExplicitSubType = false,
}) {
  var sb = StringBuffer();
  var classNameTrimmed = className.replaceAll("\$", "");
  var interfaceNameTrimmed = interfaceName.replaceAll("\$", "");

  // Determine if this is a conversion to superclass or regular copyWith
  var isConversionToSuperclass =
      !isExplicitSubType &&
      interfaceNameTrimmed != classNameTrimmed &&
      !interfaceName.startsWith("\$\$");

  var methodName = isConversionToSuperclass
      ? "changeTo$interfaceNameTrimmed"
      : isExplicitSubType
      ? "changeTo$interfaceNameTrimmed"
      : "copyWith$interfaceNameTrimmed";

  sb.write("$interfaceNameTrimmed ");
  sb.write("$methodName");

  sb.write("(");

  // Only include fields that are in the target interface
  var fieldsForSignature = classFields.where(
    (element) => interfaceFields.map((e) => e.name).contains(element.name),
  );

  // Generate parameters
  if (fieldsForSignature.isNotEmpty) {
    sb.writeln("{");

    // Only include patch for copyWith operations
    if (!isConversionToSuperclass) {
      sb.writeln("${interfaceNameTrimmed}Patch? patch,");
    }

    // Generate function parameters for fields
    sb.write(
      fieldsForSignature
          .map((e) {
            var type = getDataTypeWithoutDollars(e.type ?? "dynamic");
            var name = e.name.startsWith("_") ? e.name.substring(1) : e.name;
            return "$type Function()? $name,";
          })
          .join("\n"),
    );

    sb.writeln("}");
  }

  if (isClassAbstract && !isExplicitSubType) {
    sb.write(");");
    return sb.toString();
  }

  sb.writeln(") {");

  // Create appropriate patch
  sb.writeln("final _patch = ${interfaceNameTrimmed}Patch();");

  // Add field assignments
  for (var field in fieldsForSignature) {
    var name = field.name.startsWith("_")
        ? field.name.substring(1)
        : field.name;
    sb.writeln("""
    if ($name != null) {
      _patch.with$name($name());
    }""");
  }

  // Get the patch map
  sb.writeln("var _patchMap = _patch.toPatch();");

  // MODIFY THIS SECTION to handle nested patches
  sb.writeln("return $interfaceNameTrimmed(");
  for (var field in fieldsForSignature) {
    var name = field.name.startsWith("_")
        ? field.name.substring(1)
        : field.name;
    var baseType = getDataTypeWithoutDollars(field.type ?? "dynamic");

    // Check if it's a complex type that might need nested patch handling
    if (!PRIMITIVE_TYPES.any(
      (primitiveType) => baseType.replaceAll("?", "").startsWith(primitiveType),
    )) {
      sb.writeln("""
      $name: this.$name?.copyWith${baseType}(
        patchInput: _patchMap[${interfaceNameTrimmed}\$.$name]
      ) ?? this.$name,""");
    } else {
      // Handle primitive types normally
      sb.writeln(
        "      $name: _patchMap[${interfaceNameTrimmed}\$.$name] ?? this.$name,",
      );
    }
  }
  sb.writeln("  );");

  sb.writeln("}");

  return sb.toString();
}

bool isAbstract(String name) {
  return ['Participant', 'Entity'].contains(name.replaceAll("\$", ""));
}

String getConstructorParams(
  List<NameType> classFields,
  List<NameType> interfaceFields,
  String className,
) {
  var classNameTrim = className.replaceAll("\$", "");
  var enumName = '${classNameTrim}\$';
  var sb = StringBuffer();

  for (var field in classFields) {
    var name = field.name.startsWith("_")
        ? field.name.substring(1)
        : field.name;
    sb.writeln("      $name: _patch._patch[$enumName.$name] ?? this.$name,");
  }

  return sb.toString();
}

String getGenericString(List<NameType> generics, {bool withExtends = false}) {
  if (generics.isEmpty) return '';

  final genericList = generics
      .map((g) => withExtends ? "${g.name} extends ${g.type}" : g.name)
      .join(", ");

  return "<$genericList>";
}

String getConstructorName(String trimmedClassName, bool hasCustomConstructor) {
  return hasCustomConstructor //
      ? "$trimmedClassName._"
      : trimmedClassName;
}

String generateFromJsonHeader(String className) {
  var _className = "${className.replaceFirst("\$", "")}";
  return "factory ${_className.replaceFirst("\$", "")}.fromJson(Map<String, dynamic> json) {";
}

String generateFromJsonBody(
  String className,
  List<NameType> generics,
  List<Interface> interfaces,
) {
  var _class = Interface(
    className,
    generics.map((e) => e.type ?? "").toList(),
    generics.map((e) => e.name).toList(),
    [],
  );
  var _classes = [...interfaces, _class];
  var _className = className.replaceAll("\$", "");

  var body =
      """if (json['_className_'] == null) {
      return _\$${_className}FromJson(json);
    }
""";

  // Add interface checks
  var interfaceChecks = _classes
      .where((c) => !c.interfaceName.startsWith("\$\$"))
      .mapIndexed((i, c) {
        var _interfaceName = "${c.interfaceName.replaceFirst("\$", "")}";
        var genericTypes = c.typeParams.map((e) => "'_${e.name}_'").join(",");
        var isCurrentClass = _interfaceName == className.replaceAll("\$", "");
        var prefix = i == 0 ? "if" : "} else if";

        if (c.typeParams.length > 0) {
          return """$prefix (json['_className_'] == "$_interfaceName") {
      var fn_fromJson = getFromJsonToGenericFn(
        ${_interfaceName}_Generics_Sing().fns,
        json,
        [$genericTypes],
      );
      return fn_fromJson(json);""";
        } else {
          return """$prefix (json['_className_'] == "$_interfaceName") {
      return ${isCurrentClass ? "_\$" : ""}${_interfaceName}${isCurrentClass ? "FromJson" : ".fromJson"}(json);""";
        }
      })
      .join("\n");

  body += interfaceChecks;
  if (interfaceChecks.isNotEmpty) body += "\n}";

  body +=
      """
    throw UnsupportedError("The _className_ '\${json['_className_']}' is not supported by the ${_className}.fromJson constructor.");
    }""";

  return body;
}

String generateToJson(String className, List<NameType> generics) {
  if (className.startsWith("\$\$")) {
    return "Map<String, dynamic> toJsonCustom([Map<Type, Object? Function(Never)>? fns]);";
  }

  var _className = "${className.replaceFirst("\$", "")}";

  var getGenericFn = generics.isEmpty
      ? ""
      : generics
                .map(
                  (e) =>
                      "    var fn_${e.name} = getGenericToJsonFn(_fns, ${e.name});",
                )
                .join("\n") +
            "\n";

  var toJsonParams = generics.isEmpty
      ? ""
      : generics
                .map((e) => "      fn_${e.name} as Object? Function(${e.name})")
                .join(",\n") +
            "\n";

  var recordType = generics.isEmpty
      ? ""
      : generics
                .map((e) => "      data['_${e.name}_'] = ${e.name}.toString();")
                .join("\n") +
            "\n";

  var result =
      """
  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJsonCustom([Map<Type, Object? Function(Never)>? fns]){
    _fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
$getGenericFn    final Map<String, dynamic> data = _\$${_className}ToJson(this${generics.isEmpty ? "" : ",\n$toJsonParams"});

      data['_className_'] = '$_className';${recordType.isEmpty ? "" : "\n$recordType"}

    return data;
  }""";

  return result;
}

String generateToJsonLean(String className) {
  if (className.startsWith("\$\$")) {
    return "";
  }

  var _className = "${className.replaceFirst("\$", "")}";
  var result =
      """

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _\$${_className}ToJson(this,);
    return _sanitizeJson(data);
  }

  dynamic _sanitizeJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      json.remove('_className_');
      return json..forEach((key, value) {
        json[key] = _sanitizeJson(value);
      });
    } else if (json is List) {
      return json.map((e) => _sanitizeJson(e)).toList();
    }
    return json;
  }""";

  return result;
}

String createJsonSingleton(String classNameTrimmed, List<NameType> generics) {
  if (generics.length == 0) //
    return "";

  var objects = generics.map((e) => "Object").join(", ");

  var result =
      """
class ${classNameTrimmed}_Generics_Sing {
  Map<List<String>, $classNameTrimmed<${objects}> Function(Map<String, dynamic>)> fns = {};

  factory ${classNameTrimmed}_Generics_Sing() => _singleton;
  static final ${classNameTrimmed}_Generics_Sing _singleton = ${classNameTrimmed}_Generics_Sing._internal();

  ${classNameTrimmed}_Generics_Sing._internal() {}
}
    """;

  return result;
}

String commentEveryLine(String multilineString) {
  return multilineString.split('\n').map((line) => '//' + line).join('\n');
}

String generateCompareExtension(
  bool isAbstract,
  String className,
  String classNameTrimmed,
  List<NameTypeClassComment> allFields,
  List<Interface> knownInterfaces, // Add these parameters
  List<String> knownClasses, // Add these parameters
  bool generateCompareTo,
) {
  var sb = StringBuffer();
  sb.writeln();
  sb.writeln("extension ${classNameTrimmed}CompareE on ${classNameTrimmed} {");

  // First version with String keys
  sb.writeln('''
      Map<String, dynamic> compareTo$classNameTrimmed($classNameTrimmed other) {
        final Map<String, dynamic> diff = {};

        ${_generateCompareFieldsLogic(allFields, knownInterfaces, knownClasses, useEnumKeys: false)}

        return diff;
      }
    ''');

  // Second version with Enum keys
  // sb.writeln('''
  //     ${classNameTrimmed}Patch compareToEnum$classNameTrimmed($classNameTrimmed other) {
  //       final ${classNameTrimmed}Patch diff = {};

  //       ${_generateCompareFieldsLogic(allFields, knownInterfaces, knownClasses, useEnumKeys: true, enumClassName: enumClassName)}

  //       return diff;
  //     }
  //   ''');

  sb.writeln("}");
  return sb.toString();
}

String _generateCompareFieldsLogic(
  List<NameTypeClassComment> allFields,
  List<Interface> knownInterfaces,
  List<String> knownClasses, {
  required bool useEnumKeys,
  String? enumClassName,
}) {
  return allFields
      .map((field) {
        final type = field.type ?? '';
        final name = field.name;
        final isNullable = type.endsWith('?');
        final keyString = useEnumKeys
            ? '$enumClassName.${field.name}'
            : "'${field.name}'";
        final methodName = useEnumKeys ? 'compareToEnum' : 'compareTo';
        final baseType = type.replaceAll('?', ''); // Remove nullable indicator

        // Skip functions
        if (type.contains('Function')) {
          return '';
        }

        // Handle different types
        if (type.startsWith('List<') || type.startsWith('Set<')) {
          return _generateCollectionComparison(
            name,
            type,
            keyString,
            isNullable,
          );
        }

        if (type.startsWith('Map<')) {
          return _generateMapComparison(name, keyString, isNullable);
        }

        if (type.contains('DateTime')) {
          return _generateDateTimeComparison(name, keyString, isNullable);
        }

        // Check if type is a known interface or class
        final isKnownType =
            knownInterfaces.any((i) => i.interfaceName == baseType) ||
            knownClasses.contains(baseType);

        if (isKnownType) {
          return _generateKnownTypeComparison(
            name,
            baseType,
            keyString,
            methodName,
            isNullable,
          );
        }

        // Direct comparison for all other types
        return _generateSimpleComparison(name, keyString);
      })
      .where((s) => s.isNotEmpty)
      .join('\n    ');
}

String _generateCollectionComparison(
  String name,
  String type,
  String keyString,
  bool isNullable,
) {
  if (isNullable) {
    return '''
    if ($name != other.$name) {
      if ($name != null && other.$name != null) {
        if ($name!.length != other.$name!.length) {
          diff[$keyString] = () => other.$name;
        } else {
          var hasDiff = false;
          for (var i = 0; i < $name!.length; i++) {
            if ($name![i] != other.$name![i]) {
              hasDiff = true;
              break;
            }
          }
          if (hasDiff) {
            diff[$keyString] = () => other.$name;
          }
        }
      } else {
        diff[$keyString] = () => other.$name;
      }
    }''';
  }

  return '''
    if ($name != other.$name) {
      if ($name.length != other.$name.length) {
        diff[$keyString] = () => other.$name;
      } else {
        var hasDiff = false;
        for (var i = 0; i < $name.length; i++) {
          if ($name[i] != other.$name[i]) {
            hasDiff = true;
            break;
          }
        }
        if (hasDiff) {
          diff[$keyString] = () => other.$name;
        }
      }
    }''';
}

String _generateMapComparison(String name, String keyString, bool isNullable) {
  if (isNullable) {
    return '''
    if ($name != other.$name) {
      if ($name != null && other.$name != null) {
        if ($name!.length != other.$name!.length ||
           !$name!.keys.every((k) => other.$name!.containsKey(k) && $name![k] == other.$name![k])) {
          diff[$keyString] = () => other.$name;
        }
      } else {
        diff[$keyString] = () => other.$name;
      }
    }''';
  }

  return '''
    if ($name != other.$name) {
      if ($name.length != other.$name.length ||
         !$name.keys.every((k) => other.$name.containsKey(k) && $name[k] == other.$name[k])) {
        diff[$keyString] = () => other.$name;
      }
    }''';
}

String _generateDateTimeComparison(
  String name,
  String keyString,
  bool isNullable,
) {
  if (isNullable) {
    return '''
    if ($name != other.$name) {
      if ($name != null && other.$name != null) {
        if (!$name!.isAtSameMomentAs(other.$name!)) {
          diff[$keyString] = () => other.$name;
        }
      } else {
        diff[$keyString] = () => other.$name;
      }
    }''';
  }

  return '''
    if ($name != other.$name) {
      if (!$name.isAtSameMomentAs(other.$name)) {
        diff[$keyString] = () => other.$name;
      }
    }''';
}

String _generateKnownTypeComparison(
  String name,
  String baseType,
  String keyString,
  String methodName,
  bool isNullable,
) {
  if (isNullable) {
    return '''
    if ($name != other.$name) {
      if ($name != null && other.$name != null) {
        diff[$keyString] = () => $name!.$methodName${baseType.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')}(other.$name!);
      } else {
        diff[$keyString] = () => other.$name;
      }
    }''';
  }

  return '''
    if ($name != other.$name) {
      diff[$keyString] = () => $name.$methodName${baseType.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')}(other.$name);
    }''';
}

String _generateSimpleComparison(String name, String keyString) {
  return '''
    if ($name != other.$name) {
      diff[$keyString] = () => other.$name;
    }''';
}
