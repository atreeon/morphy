import '../common/NameType.dart';
import 'method_generator_commons.dart';
import 'parameter_generator.dart';

/// Generates abstract method signatures for interfaces
class AbstractMethodGenerator {
  /// Generate abstract copyWith method signature
  static String generateAbstractCopyWithMethod({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(
      interfaceGenerics,
      isAbstractInterface: true,
    );

    final parameters = ParameterGenerator.generateAbstractParameters(
      interfaceFields,
      interfaceGenerics,
      isAbstractInterface: true,
    );

    return '''
      $cleanInterfaceName$typeParams copyWith$cleanInterfaceName(${parameters.isNotEmpty ? '{\n        $parameters\n      }' : ''});''';
  }

  /// Generate abstract patchWith method signature
  static String generateAbstractPatchWithMethod({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(
      interfaceGenerics,
      isAbstractInterface: true,
    );

    return '''
      $cleanInterfaceName$typeParams patchWith$cleanInterfaceName({
        ${cleanInterfaceName}Patch? patchInput,
      });''';
  }

  /// Generate abstract function-based copyWith method signature
  static String generateAbstractCopyWithFunctionMethod({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(
      interfaceGenerics,
      isAbstractInterface: true,
    );

    final parameters = ParameterGenerator.generateFunctionParameters(
      interfaceFields,
      interfaceGenerics,
      isAbstractInterface: true,
    );

    return '''
      $cleanInterfaceName$typeParams copyWith${cleanInterfaceName}Fn(${parameters.isNotEmpty ? '{\n        $parameters\n      }' : ''});''';
  }

  /// Generate abstract function-based patchWith method signature
  static String generateAbstractPatchWithFunctionMethod({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(
      interfaceGenerics,
      isAbstractInterface: true,
    );

    final parameters = ParameterGenerator.generateFunctionParameters(
      interfaceFields,
      interfaceGenerics,
      isAbstractInterface: true,
    );

    return '''
      $cleanInterfaceName$typeParams patchWith${cleanInterfaceName}Fn({
        ${cleanInterfaceName}Patch? patchInput,${parameters.isNotEmpty ? '\n        $parameters' : ''}
      });''';
  }

  /// Generate all abstract method signatures for an interface
  static String generateAllAbstractMethods({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
    bool generateCopyWithFn = false,
    bool generatePatchWithFn = false,
  }) {
    final methods = <String>[];

    // Basic copyWith method
    final copyWithMethod = generateAbstractCopyWithMethod(
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      interfaceGenerics: interfaceGenerics,
    );
    if (copyWithMethod.isNotEmpty) {
      methods.add(copyWithMethod);
    }

    // Basic patchWith method
    final patchWithMethod = generateAbstractPatchWithMethod(
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      interfaceGenerics: interfaceGenerics,
    );
    if (patchWithMethod.isNotEmpty) {
      methods.add(patchWithMethod);
    }

    // Function-based copyWith method
    if (generateCopyWithFn) {
      final copyWithFnMethod = generateAbstractCopyWithFunctionMethod(
        interfaceFields: interfaceFields,
        interfaceName: interfaceName,
        interfaceGenerics: interfaceGenerics,
      );
      if (copyWithFnMethod.isNotEmpty) {
        methods.add(copyWithFnMethod);
      }
    }

    // Function-based patchWith method
    if (generatePatchWithFn) {
      final patchWithFnMethod = generateAbstractPatchWithFunctionMethod(
        interfaceFields: interfaceFields,
        interfaceName: interfaceName,
        interfaceGenerics: interfaceGenerics,
      );
      if (patchWithFnMethod.isNotEmpty) {
        methods.add(patchWithFnMethod);
      }
    }

    return methods.join('\n\n');
  }

  /// Generate minimal abstract method signatures (only required methods)
  static String generateMinimalAbstractMethods({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    return generateAllAbstractMethods(
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      interfaceGenerics: interfaceGenerics,
      generateCopyWithFn: false,
      generatePatchWithFn: false,
    );
  }

  /// Generate comprehensive abstract method signatures (all methods)
  static String generateComprehensiveAbstractMethods({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    return generateAllAbstractMethods(
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      interfaceGenerics: interfaceGenerics,
      generateCopyWithFn: true,
      generatePatchWithFn: true,
    );
  }

  /// Generate multiple abstract method signatures for multiple interfaces
  static String generateMultipleAbstractMethods({
    required Map<String, List<NameType>> interfaceFieldsMap,
    required Map<String, List<NameType>> interfaceGenericsMap,
    bool generateCopyWithFn = false,
    bool generatePatchWithFn = false,
  }) {
    final methods = <String>[];

    interfaceFieldsMap.forEach((interfaceName, interfaceFields) {
      final interfaceGenerics = interfaceGenericsMap[interfaceName] ?? [];

      final interfaceMethods = generateAllAbstractMethods(
        interfaceFields: interfaceFields,
        interfaceName: interfaceName,
        interfaceGenerics: interfaceGenerics,
        generateCopyWithFn: generateCopyWithFn,
        generatePatchWithFn: generatePatchWithFn,
      );

      if (interfaceMethods.isNotEmpty) {
        methods.add(interfaceMethods);
      }
    });

    return methods.join('\n\n');
  }

  /// Check if interface needs abstract methods
  static bool needsAbstractMethods(String interfaceName) {
    return !NameCleaner.isAbstract(interfaceName);
  }

  /// Generate abstract method signature with custom return type
  static String generateCustomAbstractMethod({
    required String methodName,
    required String returnType,
    required List<NameType> parameters,
    required List<NameType> interfaceGenerics,
  }) {
    final paramStrings = parameters
        .map((p) {
          final name = MethodGeneratorCommons.getCleanFieldName(p.name);
          final resolvedType = TypeResolver.resolveGenericType(
            p.type,
            interfaceGenerics,
            isAbstractInterface: true,
          );
          final cleanedType = FieldTypeAnalyzer.cleanType(resolvedType);
          final nullableType = cleanedType.endsWith('?')
              ? cleanedType
              : '$cleanedType?';
          return '$nullableType $name';
        })
        .join(',\n        ');

    return '''
      $returnType $methodName(${paramStrings.isNotEmpty ? '{\n        $paramStrings\n      }' : ''});''';
  }
}
