import '../common/NameType.dart';
import 'method_generator_commons.dart';
import 'parameter_generator.dart';
import 'constructor_parameter_generator.dart';

/// Generates changeTo methods that create new instances with specified changes
class ChangeToMethodGenerator {
  /// Generate a changeTo method for an interface
  static String generateChangeToMethod({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    List<NameType> interfaceGenerics = const [],
    List<String> knownClasses = const [],
    bool isInterfaceSealed = false,
    List<NameType> classGenerics = const [],
  }) {
    if (NameCleaner.isAbstract(interfaceName) || isInterfaceSealed) return '';

    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    // Use class generics for type parameters when class is generic
    final typeParams = classGenerics.isNotEmpty
        ? TypeResolver.generateTypeParams(
            classGenerics,
            isAbstractInterface: true,
          )
        : '';

    final parameters = ParameterGenerator.generateChangeToParameters(
      interfaceFields,
      classFields,
      interfaceGenerics,
      isAbstractInterface: false,
    );

    final patchAssignments = ParameterGenerator.generatePatchAssignments(
      interfaceFields,
      classFields,
    );

    final constructorParams =
        ConstructorParameterGenerator.generateChangeToConstructorParams(
          interfaceFields,
          classFields,
          cleanInterfaceName,
          interfaceGenerics,
          knownClasses,
        );

    // Skip generation if no meaningful parameters
    if (parameters.trim().isEmpty && constructorParams.trim().isEmpty) {
      return '';
    }

    return '''
      $cleanInterfaceName changeTo$cleanInterfaceName(${parameters.isNotEmpty ? '{\n        $parameters\n      }' : ''}) {
        final _patcher = ${cleanInterfaceName}Patch();
        $patchAssignments
        final _patchMap = _patcher.toPatch();
        return $cleanInterfaceName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate changeTo method for class fields
  static String generateClassChangeToMethod({
    required List<NameType> classFields,
    required String className,
    required List<NameType> classGenerics,
    List<String> knownClasses = const [],
  }) {
    final cleanClassName = NameCleaner.clean(className);
    final typeParams = TypeResolver.generateTypeParams(classGenerics);

    final parameters = ParameterGenerator.generateCopyWithParameters(
      classFields,
      classGenerics,
      isAbstractInterface: false,
    );

    final patchAssignments = ParameterGenerator.generatePatchAssignments(
      classFields,
      [],
    );

    final constructorParams = _generateSimpleClassChangeToConstructorParams(
      classFields,
      cleanClassName,
    );

    return '''
      $cleanClassName changeTo$cleanClassName(${parameters.isNotEmpty ? '{\n        $parameters\n      }' : ''}) {
        final _patcher = ${cleanClassName}Patch();
        $patchAssignments
        final _patchMap = _patcher.toPatch();
        return $cleanClassName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate constructor parameters for simple class changeTo
  static String _generateSimpleClassChangeToConstructorParams(
    List<NameType> classFields,
    String className,
  ) {
    final constructorFields = classFields.map((f) {
      final name = MethodGeneratorCommons.getCleanFieldName(f.name);
      return '$name: _patchMap[$className\$.$name]';
    });

    return constructorFields.join(',\n          ');
  }

  /// Generate multiple changeTo methods for a class implementing multiple interfaces
  static String generateMultipleChangeToMethods({
    required List<NameType> classFields,
    required Map<String, List<NameType>> interfaceFieldsMap,
    required Map<String, List<NameType>> interfaceGenericsMap,
    required String className,
    required bool isClassAbstract,
    List<String> knownClasses = const [],
    Map<String, bool> interfaceSealedMap = const {},
    List<NameType> classGenerics = const [],
  }) {
    final methods = <String>[];

    // Generate changeTo for each interface
    interfaceFieldsMap.forEach((interfaceName, interfaceFields) {
      final interfaceGenerics = interfaceGenericsMap[interfaceName] ?? [];
      final isInterfaceSealed = interfaceSealedMap[interfaceName] ?? false;

      final method = generateChangeToMethod(
        classFields: classFields,
        interfaceFields: interfaceFields,
        interfaceName: interfaceName,
        className: className,
        isClassAbstract: isClassAbstract,
        interfaceGenerics: interfaceGenerics,
        knownClasses: knownClasses,
        isInterfaceSealed: isInterfaceSealed,
        classGenerics: classGenerics,
      );

      if (method.isNotEmpty) {
        methods.add(method);
      }
    });

    return methods.join('\n\n');
  }

  /// Generate changeTo method with function-based parameters
  static String generateChangeToFunctionMethod({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required List<NameType> interfaceGenerics,
    List<String> knownClasses = const [],
    bool isInterfaceSealed = false,
  }) {
    if (NameCleaner.isAbstract(interfaceName) || isInterfaceSealed) return '';

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
        ConstructorParameterGenerator.generateChangeToConstructorParams(
          interfaceFields,
          classFields,
          cleanInterfaceName,
          interfaceGenerics,
          knownClasses,
        );

    // Skip generation if no meaningful parameters
    if (parameters.trim().isEmpty && constructorParams.trim().isEmpty) {
      return '';
    }

    return '''
      $cleanInterfaceName changeTo${cleanInterfaceName}Fn(${parameters.isNotEmpty ? '{\n        $parameters\n      }' : ''}) {
        final _patcher = ${cleanInterfaceName}Patch();
        $patchAssignments
        final _patchMap = _patcher.toPatch();
        return $cleanInterfaceName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate changeTo method that preserves some fields from the current instance
  static String generatePartialChangeToMethod({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required List<NameType> preserveFields,
    required String interfaceName,
    required String className,
    required List<NameType> interfaceGenerics,
    List<String> knownClasses = const [],
    bool isInterfaceSealed = false,
  }) {
    if (NameCleaner.isAbstract(interfaceName) || isInterfaceSealed) return '';

    final cleanInterfaceName = NameCleaner.clean(interfaceName);
    final typeParams = TypeResolver.generateTypeParams(interfaceGenerics);

    // Only generate parameters for fields that are NOT preserved
    final preserveFieldNames = preserveFields.map((f) => f.name).toSet();
    final changeableFields = interfaceFields
        .where((f) => !preserveFieldNames.contains(f.name))
        .toList();

    final parameters = ParameterGenerator.generateChangeToParameters(
      changeableFields,
      classFields,
      interfaceGenerics,
      isAbstractInterface: false,
    );

    final patchAssignments = ParameterGenerator.generatePatchAssignments(
      changeableFields,
      classFields,
    );

    final constructorParams = _generatePartialChangeToConstructorParams(
      interfaceFields,
      classFields,
      preserveFields,
      cleanInterfaceName,
      interfaceGenerics,
      knownClasses,
    );

    return '''
      $cleanInterfaceName partialChangeTo$cleanInterfaceName(${parameters.isNotEmpty ? '{\n        $parameters\n      }' : ''}) {
        final _patcher = ${cleanInterfaceName}Patch();
        $patchAssignments
        final _patchMap = _patcher.toPatch();
        return $cleanInterfaceName._(${constructorParams.isNotEmpty ? '\n          $constructorParams\n        ' : ''});
      }''';
  }

  /// Generate constructor parameters for partial changeTo
  static String _generatePartialChangeToConstructorParams(
    List<NameType> targetFields,
    List<NameType> classFields,
    List<NameType> preserveFields,
    String targetClassName,
    List<NameType> genericParams,
    List<String> knownClasses,
  ) {
    final preserveFieldNames = preserveFields.map((f) => f.name).toSet();
    final genericTypeNames = genericParams
        .map((g) => FieldTypeAnalyzer.cleanType(g.type))
        .toSet();

    final constructorFields = targetFields.map((f) {
      final name = MethodGeneratorCommons.getCleanFieldName(f.name);
      final isPreserved = preserveFieldNames.contains(f.name);

      if (isPreserved) {
        // Preserve current value for this field
        return '$name: this.$name';
      } else {
        // Use patch value for changeable fields
        final baseType = FieldTypeAnalyzer.cleanType(
          f.type,
        ).replaceAll("?", "");
        final isEnum = f.isEnum;
        final isGenericType = TypeResolver.isGenericType(
          baseType,
          genericParams,
        );

        if (MethodGeneratorCommons.needsPatchHandling(
          baseType,
          isEnum,
          isGenericType,
          knownClasses,
        )) {
          final patchType = MethodGeneratorCommons.getPatchType(baseType);
          return '''$name: (_patchMap[$targetClassName\$.$name] is $patchType)
            ? (this.$name?.copyWith$baseType(
                patchInput: _patchMap[$targetClassName\$.$name]
              ) ?? (() {
                try {
                  return $baseType.fromJson(
                    (_patchMap[$targetClassName\$.$name] as $patchType).toJson()
                  );
                } catch (e) {
                  throw StateError(
                    'Failed to create new $baseType instance from patch. '
                    'The field "$name" is null and the patch does not contain all required fields. '
                    'Error: \${e.toString()}'
                  );
                }
              })())
            : _patchMap[$targetClassName\$.$name]''';
        }
        return '$name: _patchMap[$targetClassName\$.$name]';
      }
    });

    return constructorFields.join(',\n          ');
  }
}
