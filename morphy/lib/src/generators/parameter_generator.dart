import '../common/NameType.dart';
import 'method_generator_commons.dart';

/// Generates method parameters for various types of methods
class ParameterGenerator {
  /// Generate parameters for copyWith methods (simple, no patchInput)
  static String generateCopyWithParameters(
    List<NameType> targetFields,
    List<NameType> interfaceGenerics, {
    bool isAbstractInterface = false,
  }) {
    final parameters = targetFields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          final cleanedType = FieldTypeAnalyzer.cleanType(resolvedType);
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
          final cleanedType = FieldTypeAnalyzer.cleanType(resolvedType);
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
  }) {
    final parameters = fields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          final cleanedType = FieldTypeAnalyzer.cleanType(resolvedType);
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
  }) {
    final parameters = targetFields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final resolvedType = TypeResolver.resolveGenericType(
            f.type,
            interfaceGenerics,
            isAbstractInterface: isAbstractInterface,
          );
          final cleanedType = FieldTypeAnalyzer.cleanType(resolvedType);
          return '$cleanedType Function()? $name';
        })
        .join(',\n        ');

    return parameters.isEmpty ? '' : parameters;
  }

  /// Generate patch assignments for patchWith methods
  static String generatePatchAssignments(
    List<NameType> fields,
    List<NameType> sourceFields,
  ) {
    final sourceFieldNames = sourceFields.map((e) => e.name).toSet();

    return fields
        .map((f) {
          final name = MethodGeneratorCommons.getCleanFieldName(f.name);
          final isRequired = !f.type!.endsWith('?');
          final hasField = sourceFieldNames.contains(f.name);
          final capitalizedName =
              MethodGeneratorCommons.getCapitalizedFieldName(f.name);

          // Required fields - direct assignment
          if (isRequired && !hasField) {
            return "_patcher.with$capitalizedName($name);";
          } else {
            // Optional fields - null check
            return """
            if ($name != null) {
              _patcher.with$capitalizedName($name);
            }""";
          }
        })
        .join("\n");
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
