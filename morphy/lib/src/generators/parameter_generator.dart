import '../common/NameType.dart';
import 'method_generator_commons.dart';

/// Generates method parameters for various types of methods
class ParameterGenerator {
  /// Generate parameters for copyWith methods (simple, no patchInput)
  static String generateCopyWithParameters(
    List<NameType> targetFields,
    List<NameType> interfaceGenerics, {
    bool isAbstractInterface = false,
    bool isInterfaceMethod = false,
  }) {
    final parameters = targetFields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          // Skip type cleaning for interface methods to preserve $ prefix
          final cleanedType = isInterfaceMethod
              ? resolvedType
              : FieldTypeAnalyzer.cleanType(resolvedType);

          final nullableType = cleanedType.endsWith('?')
              ? cleanedType
              : '$cleanedType?';
          return '$nullableType $name';
        })
        .join(',\n        ');

    return parameters.isEmpty ? '' : parameters;
  }

  /// Generate parameters for changeTo methods
  static String generateChangeToParameters(
    List<NameType> targetFields,
    List<NameType> sourceFields,
    List<NameType> interfaceGenerics, {
    bool isAbstractInterface = false,
    bool isInterfaceMethod = false,
  }) {
    final sourceFieldNames = sourceFields.map((f) => f.name).toSet();

    final parameters = targetFields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final hasField = sourceFieldNames.contains(f.name);
          final isRequired = !f.type!.endsWith('?');

          // Required only if field is required AND not in source
          if (isRequired && !hasField) {
            return 'required ${FieldTypeAnalyzer.cleanType(f.type)} $name';
          }

          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          // Skip type cleaning for interface methods to preserve $ prefix
          final cleanedType = isInterfaceMethod
              ? resolvedType
              : FieldTypeAnalyzer.cleanType(resolvedType);

          final nullableType = cleanedType.endsWith('?')
              ? cleanedType
              : '$cleanedType?';
          return '$nullableType $name';
        })
        .join(',\n        ');

    return parameters.isEmpty ? '' : parameters;
  }

  /// Generate parameters for abstract method signatures
  static String generateAbstractParameters(
    List<NameType> fields,
    List<NameType> interfaceGenerics, {
    bool isAbstractInterface = true,
    bool isInterfaceMethod = false,
  }) {
    final parameters = fields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          // Skip type cleaning for interface methods to preserve $ prefix
          final cleanedType = isInterfaceMethod
              ? resolvedType
              : FieldTypeAnalyzer.cleanType(resolvedType);

          final nullableType = cleanedType.endsWith('?')
              ? cleanedType
              : '$cleanedType?';
          return '$nullableType $name';
        })
        .join(',\n        ');

    return parameters.isEmpty ? '' : parameters;
  }

  /// Generate function parameters for function-based copyWith methods
  static String generateFunctionParameters(
    List<NameType> targetFields,
    List<NameType> interfaceGenerics, {
    bool isAbstractInterface = false,
    bool isInterfaceMethod = false,
  }) {
    final parameters = targetFields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          // Skip type cleaning for interface methods to preserve $ prefix
          final cleanedType = isInterfaceMethod
              ? resolvedType
              : FieldTypeAnalyzer.cleanType(resolvedType);

          return '$cleanedType Function()? $name';
        })
        .join(',\n        ');

    return parameters.isEmpty ? '' : parameters;
  }

  /// Generate patch assignments for patchWith methods
  static String generatePatchAssignments(
    List<NameType> fields,
    List<NameType> sourceFields, {
    bool isInterfaceMethod = false,
  }) {
    final sourceFieldNames = sourceFields.map((e) => e.name).toSet();

    return fields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final isRequired = !f.type!.endsWith('?');
          final hasField = sourceFieldNames.contains(f.name);
          final capitalizedName =
              MethodGeneratorCommons.getCapitalizedFieldName(f.name);

          // Check if we need casting from $Type to Type
          final originalType = f.type ?? '';
          final needsCasting = originalType.contains('\$') && isInterfaceMethod;

          final castingCode = needsCasting
              ? _generateTypeCasting(originalType)
              : '';

          // Required fields - direct assignment
          if (isRequired && !hasField) {
            return "_patcher.with$capitalizedName($name$castingCode);";
          } else {
            // Optional fields - null check
            return """
            if ($name != null) {
              _patcher.with$capitalizedName($name$castingCode);
            }""";
          }
        })
        .join("\n");
  }

  /// Generate appropriate casting code for $Type to Type conversion
  static String _generateTypeCasting(String originalType) {
    // Handle List<$X> -> List<X> casting
    if (originalType.contains('List<\$')) {
      final match = RegExp(r'List<\$(\w+)>').firstMatch(originalType);
      if (match != null) {
        final innerType = match.group(1);
        return '.cast<$innerType>()';
      }
    }

    // Handle simple $Type -> Type casting
    if (originalType.startsWith('\$')) {
      final cleanType = originalType.replaceFirst('\$', '');
      return ' as $cleanType';
    }

    return '';
  }

  /// Generate function-based patch assignments
  static String generateFunctionPatchAssignments(List<NameType> targetFields) {
    return targetFields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final capitalizedName =
              MethodGeneratorCommons.getCapitalizedFieldName(f.name);

          return '''
        if ($name != null) {
          _patcher.with$capitalizedName($name());
        }''';
        })
        .join('');
  }
}
