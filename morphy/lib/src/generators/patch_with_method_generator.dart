import '../common/NameType.dart';
import 'method_generator_commons.dart';
import 'parameter_generator.dart';
import 'constructor_parameter_generator.dart';

/// Generates patchWith methods that accept PatchInput parameters
class PatchWithMethodGenerator {
  /// Generate a patchWith method for an interface
  static String generatePatchWithMethod({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    required List<NameType> interfaceGenerics,
    List<String> knownClasses = const [],
  }) {
    if (NameCleaner.isAbstract(interfaceName)) return '';

    final cleanClassName = NameCleaner.clean(className);
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(interfaceGenerics);

    final constructorParams =
        ConstructorParameterGenerator.generatePatchWithConstructorParams(
          classFields,
          interfaceFields,
          cleanInterfaceName,
          interfaceGenerics,
          knownClasses,
        );

    return '''
      $cleanClassName patchWith$cleanInterfaceName({
        ${cleanInterfaceName}Patch? patchInput,
      }) {
        final _patcher = patchInput ?? ${cleanInterfaceName}Patch();
        final _patchMap = _patcher.toPatch();
        return $cleanClassName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate patchWith method for class fields
  static String generateClassPatchWithMethod({
    required List<NameType> classFields,
    required String className,
    required List<NameType> classGenerics,
    List<String> knownClasses = const [],
  }) {
    final cleanClassName = NameCleaner.clean(className);
    final typeParams = TypeResolver.generateTypeParams(classGenerics);

    final constructorParams = _generateSimpleClassPatchConstructorParams(
      classFields,
      cleanClassName,
    );

    return '''
      $cleanClassName patchWith$cleanClassName({
        ${cleanClassName}Patch? patchInput,
      }) {
        final _patcher = patchInput ?? ${cleanClassName}Patch();
        final _patchMap = _patcher.toPatch();
        return $cleanClassName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate constructor parameters for simple class patchWith
  static String _generateSimpleClassPatchConstructorParams(
    List<NameType> classFields,
    String className,
  ) {
    final constructorFields = classFields.map((f) {
      final name = MethodGeneratorCommons.getCleanFieldName(f.name);
      return '$name: _patchMap.containsKey($className\$.$name) ? _patchMap[$className\$.$name] : this.$name';
    });

    return constructorFields.join(',\n          ');
  }

  /// Generate multiple patchWith methods for a class implementing multiple interfaces
  static String generateMultiplePatchWithMethods({
    required List<NameType> classFields,
    required Map<String, List<NameType>> interfaceFieldsMap,
    required Map<String, List<NameType>> interfaceGenericsMap,
    required String className,
    required bool isClassAbstract,
    List<String> knownClasses = const [],
  }) {
    final methods = <String>[];

    // Generate patchWith for each interface
    interfaceFieldsMap.forEach((interfaceName, interfaceFields) {
      final interfaceGenerics = interfaceGenericsMap[interfaceName] ?? [];

      final method = generatePatchWithMethod(
        classFields: classFields,
        interfaceFields: interfaceFields,
        interfaceName: interfaceName,
        className: className,
        isClassAbstract: isClassAbstract,
        interfaceGenerics: interfaceGenerics,
        knownClasses: knownClasses,
      );

      if (method.isNotEmpty) {
        methods.add(method);
      }
    });

    return methods.join('\n\n');
  }

  /// Generate patchWith method that combines patchInput with direct parameters
  static String generateHybridPatchWithMethod({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required List<NameType> interfaceGenerics,
    List<String> knownClasses = const [],
  }) {
    if (NameCleaner.isAbstract(interfaceName)) return '';

    final cleanClassName = NameCleaner.clean(className);
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(interfaceGenerics);

    final parameters = ParameterGenerator.generateCopyWithParameters(
      interfaceFields,
      interfaceGenerics,
      isAbstractInterface: false,
    );

    final patchAssignments = ParameterGenerator.generatePatchAssignments(
      interfaceFields,
      classFields,
    );

    final constructorParams =
        ConstructorParameterGenerator.generatePatchWithConstructorParams(
          classFields,
          interfaceFields,
          cleanInterfaceName,
          interfaceGenerics,
          knownClasses,
        );

    return '''
      $cleanClassName patchWith${cleanInterfaceName}Hybrid({
        ${cleanInterfaceName}Patch? patchInput,${parameters.isNotEmpty ? '\n        $parameters' : ''}
      }) {
        final _patcher = patchInput ?? ${cleanInterfaceName}Patch();
        $patchAssignments
        final _patchMap = _patcher.toPatch();
        return $cleanClassName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate patchWith method with function-based parameters
  static String generatePatchWithFunctionMethod({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required List<NameType> interfaceGenerics,
    List<String> knownClasses = const [],
  }) {
    if (NameCleaner.isAbstract(interfaceName)) return '';

    final cleanClassName = NameCleaner.clean(className);
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(interfaceGenerics);

    final parameters = ParameterGenerator.generateFunctionParameters(
      interfaceFields,
      interfaceGenerics,
      isAbstractInterface: false,
    );

    final patchAssignments =
        ParameterGenerator.generateFunctionPatchAssignments(interfaceFields);

    final constructorParams =
        ConstructorParameterGenerator.generatePatchWithConstructorParams(
          classFields,
          interfaceFields,
          cleanInterfaceName,
          interfaceGenerics,
          knownClasses,
        );

    return '''
      $cleanClassName patchWith${cleanInterfaceName}Fn({
        ${cleanInterfaceName}Patch? patchInput,${parameters.isNotEmpty ? '\n        $parameters' : ''}
      }) {
        final _patcher = patchInput ?? ${cleanInterfaceName}Patch();
        $patchAssignments
        final _patchMap = _patcher.toPatch();
        return $cleanClassName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate abstract patchWith method signature
  static String generateAbstractPatchWithMethod({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
  }) {
    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(interfaceGenerics);

    return '''
      $cleanInterfaceName$typeParams patchWith$cleanInterfaceName({
        ${cleanInterfaceName}Patch? patchInput,
      });''';
  }
}
