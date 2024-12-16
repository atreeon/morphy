import 'common/NameType.dart';
import 'helpers.dart';

class MethodGenerator {
  static String _generateTypeParams(List<NameType> generics) {
    if (generics.isEmpty) return '';
    return '<${generics.map((g) => FieldTypeAnalyzer.cleanType(g.type)).join(', ')}>';
  }

  static String generateCopyWithMethods({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    List<NameType> interfaceGenerics = const [], // Add this parameter
  }) {
    if (NameCleaner.isAbstract(interfaceName)) return '';

    final cleanClassName = NameCleaner.clean(className);
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = _generateTypeParams(interfaceGenerics);

    return '''
      $cleanClassName$typeParams copyWith$cleanInterfaceName({
        ${cleanInterfaceName}Patch? patchInput,
        ${_generateParameters(interfaceFields, classFields, true)}
      }) {
        final _patcher = patchInput ?? ${cleanInterfaceName}Patch();
        ${_generatePatchAssignments(interfaceFields, classFields, true)}
        final _patchMap = _patcher.toPatch();
        return $cleanClassName._$typeParams(
          ${_generateConstructorParams(classFields, interfaceFields, cleanInterfaceName, false)}
        );
      }''';
  }

  static String generateChangeToMethods({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    List<NameType> interfaceGenerics = const [], // Add this parameter
  }) {
    if (NameCleaner.isAbstract(interfaceName)) return '';

    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = _generateTypeParams(interfaceGenerics);

    return '''
      $cleanInterfaceName$typeParams changeTo$cleanInterfaceName({
        ${_generateParameters(interfaceFields, classFields, false)}
      }) {
        final _patcher = ${cleanInterfaceName}Patch();
        ${_generatePatchAssignments(interfaceFields, classFields, true)}
        final _patchMap = _patcher.toPatch();
        return $cleanInterfaceName$typeParams(
          ${_generateConstructorParams(interfaceFields, classFields, cleanInterfaceName, true)}
        );
      }''';
  }

  static String _generatePatchAssignments(
      List<NameType> fields, List<NameType> sourceFields, bool isCopyWith) {
    var sourceFieldNames = sourceFields.map((e) => e.name).toSet();

    return fields.map((f) {
      var name = f.name.startsWith("_") ? f.name.substring(1) : f.name;
      var isRequired = !f.type!.endsWith('?');
      var hasField = sourceFieldNames.contains(f.name);
      var capitalizedName =
          name.substring(0, 1).toUpperCase() + name.substring(1);
      if (isRequired && !hasField) {
        // Required fields - direct assignment
        return "_patcher.with$capitalizedName($name());";
      } else {
        // Optional fields - null check
        return """
        if ($name != null) {
          _patcher.with$capitalizedName($name());
        }""";
      }
    }).join("\n");
  }

  static String _generateParameters(
      List<NameType> fields, List<NameType> sourceFields, bool isCopyWith) {
    var sourceFieldNames = sourceFields.map((e) => e.name).toSet();

    return fields.map((f) {
      var name = f.name.startsWith('_') ? f.name.substring(1) : f.name;
      var hasField = sourceFieldNames.contains(f.name);
      var isRequired = !f.type!.endsWith('?');

      // For copyWith - all optional
      if (isCopyWith) {
        return '${FieldTypeAnalyzer.cleanType(f.type)} Function()? $name';
      }

      // For changeTo - required only if field is required AND not in source
      if (isRequired && !hasField) {
        return 'required ${FieldTypeAnalyzer.cleanType(f.type)} Function() $name';
      }

      return '${FieldTypeAnalyzer.cleanType(f.type)} Function()? $name';
    }).join(',\n      ');
  }

  // static String _generateConstructorParams(List<NameType> targetClassFields,
  //     List<NameType> sourceFields, String targetClassName, bool isChangeTo) {
  //   var sourceFieldNames = sourceFields.map((e) => e.name).toSet();

  //   // For changeTo methods, we don't use private constructor
  //   var constructorFields = targetClassFields.map((f) {
  //     var name = f.name.startsWith('_') ? f.name.substring(1) : f.name;
  //     var hasField = sourceFieldNames.contains(f.name);
  //     var baseType = FieldTypeAnalyzer.cleanType(f.type).replaceAll("?", "");
  //     var isEnum = f.isEnum;

  //     if (hasField) {
  //       // Check if it's a complex type that might need nested patch handling
  //       if (!PRIMITIVE_TYPES.any((primitiveType) =>
  //               baseType.replaceAll("?", "").startsWith(primitiveType)) &&
  //           !isEnum) {
  //         return '''$name: (_patchMap[$targetClassName\$.$name] is ${baseType}Patch)
  //           ? (this.$name?.copyWith$baseType(
  //               patchInput: _patchMap[$targetClassName\$.$name]
  //             ) ?? $baseType.fromJson(
  //               (_patchMap[$targetClassName\$.$name] as ${baseType}Patch).toJson()
  //             ))
  //           : _patchMap[$targetClassName\$.$name] ?? this.$name''';
  //       }
  //       return '$name: _patchMap[$targetClassName\$.$name] ?? this.$name';
  //     } else if (!isChangeTo) {
  //       // For copyWith, keep existing values
  //       return '$name: this.$name';
  //     } else {
  //       // For changeTo, use only patch values for new fields
  //       return '$name: _patchMap[$targetClassName\$.$name]';
  //     }
  //   });

  //   return constructorFields.join(',\n        ');
  // }

  static String _generateConstructorParams(List<NameType> targetClassFields,
      List<NameType> sourceFields, String targetClassName, bool isChangeTo) {
    var sourceFieldNames = sourceFields.map((e) => e.name).toSet();

    var constructorFields = targetClassFields.map((f) {
      var name = f.name.startsWith('_') ? f.name.substring(1) : f.name;
      var hasField = sourceFieldNames.contains(f.name);
      var baseType = FieldTypeAnalyzer.cleanType(f.type).replaceAll("?", "");
      var isEnum = f.isEnum;

      if (hasField) {
        if (!PRIMITIVE_TYPES.any((primitiveType) =>
                baseType.replaceAll("?", "").startsWith(primitiveType)) &&
            !isEnum) {
          return '''$name: (_patchMap[$targetClassName\$.$name] is ${baseType}Patch)
            ? (this.$name?.copyWith$baseType(
                patchInput: _patchMap[$targetClassName\$.$name]
              ) ?? (() {
                try {
                  return $baseType.fromJson(
                    (_patchMap[$targetClassName\$.$name] as ${baseType}Patch).toJson()
                  );
                } catch (e) {
                  throw StateError(
                    'Failed to create new $baseType instance from patch. '
                    'The field "$name" is null and the patch does not contain all required fields. '
                    'Error: \${e.toString()}'
                  );
                }
              })())
            : _patchMap[$targetClassName\$.$name] ?? this.$name''';
        }
        return '$name: _patchMap[$targetClassName\$.$name] ?? this.$name';
      } else if (!isChangeTo) {
        return '$name: this.$name';
      } else {
        return '$name: _patchMap[$targetClassName\$.$name]';
      }
    });

    return constructorFields.join(',\n        ');
  }
}

class NameCleaner {
  static bool isAbstract(String name) => name.startsWith('\$\$');

  static String clean(String name) {
    if (name.startsWith('\$\$')) return name.substring(2);
    if (name.startsWith('\$')) return name.substring(1);
    return name;
  }

  static String cleanType(String? type) {
    if (type == null || type == 'null') return 'dynamic';

    // Handle double nullability and dollar signs
    type =
        type.replaceAll('\$\$', '').replaceAll('\$', '').replaceAll('??', '?');

    if (type.contains('<')) {
      var match = RegExp(r'([^<]+)<(.+)>').firstMatch(type);
      if (match != null) {
        var genericType = clean(match.group(1) ?? '');
        var typeParams = match.group(2) ?? '';
        var cleanedParams =
            typeParams.split(',').map((t) => cleanType(t.trim())).join(', ');
        return '$genericType<$cleanedParams>';
      }
    }

    return clean(type);
  }

  static bool isRequired(NameType field) {
    if (field.type == null) {
      return false;
    }
    return !field.type!.contains('?');
  }

  static String formatParameterType(NameType field) {
    var cleanedType = cleanType(field.type);
    if (isRequired(field)) {
      return 'required $cleanedType Function()';
    }
    return '$cleanedType Function()?';
  }
}

class FieldTypeAnalyzer {
  static bool isRequired(NameType field) {
    if (field.type == null) {
      return false;
    }
    return !field.type!.endsWith('?');
  }

  static String cleanType(String? type) {
    if (type == null || type == 'null') return 'dynamic';

    // Remove double nullable and $ prefixes
    var cleaned =
        type.replaceAll('??', '?').replaceAll(RegExp(r'\$+(?![^<]*>)'), '');

    // Handle generic types
    if (cleaned.contains('<')) {
      var match = RegExp(r'([^<]+)<(.+)>').firstMatch(cleaned);
      if (match != null) {
        var genericType = match.group(1) ?? '';
        var params = match.group(2) ?? '';
        var cleanParams =
            params.split(',').map((t) => cleanType(t.trim())).join(', ');
        return '$genericType<$cleanParams>';
      }
    }

    return cleaned;
  }

  static String formatParameter(NameType field) {
    var cleanedType = cleanType(field.type);
    return isRequired(field)
        ? 'required $cleanedType Function()'
        : '$cleanedType Function()?';
  }
}
