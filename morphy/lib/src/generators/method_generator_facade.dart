import '../common/NameType.dart';
import 'method_generator_commons.dart';
import 'copy_with_method_generator.dart';
import 'patch_with_method_generator.dart';
import 'change_to_method_generator.dart';
import 'abstract_method_generator.dart';

/// Main facade that coordinates all method generators
/// Provides backward compatibility with the original MethodGenerator API
class MethodGeneratorFacade {
  /// Generate copyWith methods (simple, without patchInput)
  static String generateCopyWithMethods({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    required List<NameType> interfaceGenerics,
    bool generateCopyWithFn = false,
    List<String> knownClasses = const [],
  }) {
    final methods = <String>[];

    // Generate basic copyWith method
    final copyWithMethod = CopyWithMethodGenerator.generateCopyWithMethod(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      knownClasses: knownClasses,
    );

    if (copyWithMethod.isNotEmpty) {
      methods.add(copyWithMethod);
    }

    // Generate function-based copyWith method if requested
    if (generateCopyWithFn) {
      final copyWithFnMethod =
          CopyWithMethodGenerator.generateCopyWithFunctionMethod(
            classFields: classFields,
            interfaceFields: interfaceFields,
            interfaceName: interfaceName,
            className: className,
            interfaceGenerics: interfaceGenerics,
            knownClasses: knownClasses,
          );

      if (copyWithFnMethod.isNotEmpty) {
        methods.add(copyWithFnMethod);
      }
    }

    return methods.join('\n\n');
  }

  /// Generate patchWith methods (with patchInput parameter)
  static String generatePatchWithMethods({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    required List<NameType> interfaceGenerics,
    bool generatePatchWithFn = false,
    bool generateHybrid = false,
    List<String> knownClasses = const [],
  }) {
    final methods = <String>[];

    // Generate basic patchWith method
    final patchWithMethod = PatchWithMethodGenerator.generatePatchWithMethod(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      knownClasses: knownClasses,
    );

    if (patchWithMethod.isNotEmpty) {
      methods.add(patchWithMethod);
    }

    // Generate hybrid patchWith method if requested
    if (generateHybrid) {
      final hybridMethod =
          PatchWithMethodGenerator.generateHybridPatchWithMethod(
            classFields: classFields,
            interfaceFields: interfaceFields,
            interfaceName: interfaceName,
            className: className,
            interfaceGenerics: interfaceGenerics,
            knownClasses: knownClasses,
          );

      if (hybridMethod.isNotEmpty) {
        methods.add(hybridMethod);
      }
    }

    // Generate function-based patchWith method if requested
    if (generatePatchWithFn) {
      final patchWithFnMethod =
          PatchWithMethodGenerator.generatePatchWithFunctionMethod(
            classFields: classFields,
            interfaceFields: interfaceFields,
            interfaceName: interfaceName,
            className: className,
            interfaceGenerics: interfaceGenerics,
            knownClasses: knownClasses,
          );

      if (patchWithFnMethod.isNotEmpty) {
        methods.add(patchWithFnMethod);
      }
    }

    return methods.join('\n\n');
  }

  /// Generate changeTo methods
  static String generateChangeToMethods({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    List<NameType> interfaceGenerics = const [],
    List<String> knownClasses = const [],
    bool isInterfaceSealed = false,
    bool generateChangeToFn = false,
  }) {
    final methods = <String>[];

    // Generate basic changeTo method
    final changeToMethod = ChangeToMethodGenerator.generateChangeToMethod(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      knownClasses: knownClasses,
      isInterfaceSealed: isInterfaceSealed,
    );

    if (changeToMethod.isNotEmpty) {
      methods.add(changeToMethod);
    }

    // Generate function-based changeTo method if requested
    if (generateChangeToFn) {
      final changeToFnMethod =
          ChangeToMethodGenerator.generateChangeToFunctionMethod(
            classFields: classFields,
            interfaceFields: interfaceFields,
            interfaceName: interfaceName,
            className: className,
            interfaceGenerics: interfaceGenerics,
            knownClasses: knownClasses,
            isInterfaceSealed: isInterfaceSealed,
          );

      if (changeToFnMethod.isNotEmpty) {
        methods.add(changeToFnMethod);
      }
    }

    return methods.join('\n\n');
  }

  /// Generate abstract method signatures
  static String generateAbstractCopyWithMethods({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
    bool generateCopyWithFn = false,
    bool generatePatchWithFn = false,
  }) {
    return AbstractMethodGenerator.generateAllAbstractMethods(
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      interfaceGenerics: interfaceGenerics,
      generateCopyWithFn: generateCopyWithFn,
      generatePatchWithFn: generatePatchWithFn,
    );
  }

  /// Generate all methods for a class (copyWith, patchWith, changeTo)
  static String generateAllMethods({
    required List<NameType> classFields,
    required List<NameType> interfaceFields,
    required String interfaceName,
    required String className,
    required bool isClassAbstract,
    required List<NameType> interfaceGenerics,
    bool generateCopyWithFn = false,
    bool generatePatchWithFn = false,
    bool generateHybridPatch = false,
    bool generateChangeToFn = false,
    List<String> knownClasses = const [],
    bool isInterfaceSealed = false,
  }) {
    final methods = <String>[];

    // Generate copyWith methods
    final copyWithMethods = generateCopyWithMethods(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      generateCopyWithFn: generateCopyWithFn,
      knownClasses: knownClasses,
    );

    if (copyWithMethods.isNotEmpty) {
      methods.add(copyWithMethods);
    }

    // Generate patchWith methods
    final patchWithMethods = generatePatchWithMethods(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      generatePatchWithFn: generatePatchWithFn,
      generateHybrid: generateHybridPatch,
      knownClasses: knownClasses,
    );

    if (patchWithMethods.isNotEmpty) {
      methods.add(patchWithMethods);
    }

    // Generate changeTo methods
    final changeToMethods = generateChangeToMethods(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      knownClasses: knownClasses,
      isInterfaceSealed: isInterfaceSealed,
      generateChangeToFn: generateChangeToFn,
    );

    if (changeToMethods.isNotEmpty) {
      methods.add(changeToMethods);
    }

    return methods.join('\n\n');
  }

  /// Generate methods for multiple interfaces
  static String generateMultipleInterfaceMethods({
    required List<NameType> classFields,
    required Map<String, List<NameType>> interfaceFieldsMap,
    required Map<String, List<NameType>> interfaceGenericsMap,
    required String className,
    required bool isClassAbstract,
    bool generateCopyWithFn = false,
    bool generatePatchWithFn = false,
    bool generateHybridPatch = false,
    bool generateChangeToFn = false,
    List<String> knownClasses = const [],
    Map<String, bool> interfaceSealedMap = const {},
  }) {
    final allMethods = <String>[];

    // Generate copyWith methods for all interfaces
    final copyWithMethods =
        CopyWithMethodGenerator.generateMultipleCopyWithMethods(
          classFields: classFields,
          interfaceFieldsMap: interfaceFieldsMap,
          interfaceGenericsMap: interfaceGenericsMap,
          className: className,
          isClassAbstract: isClassAbstract,
          knownClasses: knownClasses,
        );

    if (copyWithMethods.isNotEmpty) {
      allMethods.add(copyWithMethods);
    }

    // Generate patchWith methods for all interfaces
    final patchWithMethods =
        PatchWithMethodGenerator.generateMultiplePatchWithMethods(
          classFields: classFields,
          interfaceFieldsMap: interfaceFieldsMap,
          interfaceGenericsMap: interfaceGenericsMap,
          className: className,
          isClassAbstract: isClassAbstract,
          knownClasses: knownClasses,
        );

    if (patchWithMethods.isNotEmpty) {
      allMethods.add(patchWithMethods);
    }

    // Generate changeTo methods for all interfaces
    final changeToMethods =
        ChangeToMethodGenerator.generateMultipleChangeToMethods(
          classFields: classFields,
          interfaceFieldsMap: interfaceFieldsMap,
          interfaceGenericsMap: interfaceGenericsMap,
          className: className,
          isClassAbstract: isClassAbstract,
          interfaceSealedMap: interfaceSealedMap,
          knownClasses: knownClasses,
        );

    if (changeToMethods.isNotEmpty) {
      allMethods.add(changeToMethods);
    }

    return allMethods.join('\n\n');
  }

  /// Generate class-specific methods (for the class's own fields)
  static String generateClassMethods({
    required List<NameType> classFields,
    required String className,
    required List<NameType> classGenerics,
    bool generateCopyWith = true,
    bool generatePatchWith = true,
    bool generateChangeTo = true,
    List<String> knownClasses = const [],
  }) {
    final methods = <String>[];

    if (generateCopyWith) {
      final copyWithMethod =
          CopyWithMethodGenerator.generateClassCopyWithMethod(
            classFields: classFields,
            className: className,
            classGenerics: classGenerics,
            knownClasses: knownClasses,
          );

      if (copyWithMethod.isNotEmpty) {
        methods.add(copyWithMethod);
      }
    }

    if (generatePatchWith) {
      final patchWithMethod =
          PatchWithMethodGenerator.generateClassPatchWithMethod(
            classFields: classFields,
            className: className,
            classGenerics: classGenerics,
            knownClasses: knownClasses,
          );

      if (patchWithMethod.isNotEmpty) {
        methods.add(patchWithMethod);
      }
    }

    if (generateChangeTo) {
      final changeToMethod =
          ChangeToMethodGenerator.generateClassChangeToMethod(
            classFields: classFields,
            className: className,
            classGenerics: classGenerics,
            knownClasses: knownClasses,
          );

      if (changeToMethod.isNotEmpty) {
        methods.add(changeToMethod);
      }
    }

    return methods.join('\n\n');
  }

  /// Check if methods should be generated for the given configuration
  static bool shouldGenerateMethods({
    required String interfaceName,
    required bool isClassAbstract,
    bool isInterfaceSealed = false,
  }) {
    return !NameCleaner.isAbstract(interfaceName) &&
        !isInterfaceSealed &&
        !isClassAbstract;
  }

  /// Get method generation configuration based on preferences
  static Map<String, bool> getMethodGenerationConfig({
    bool enableFunctionMethods = false,
    bool enableHybridMethods = false,
    bool enableChangeToMethods = true,
  }) {
    return {
      'generateCopyWithFn': enableFunctionMethods,
      'generatePatchWithFn': enableFunctionMethods,
      'generateHybridPatch': enableHybridMethods,
      'generateChangeToFn': enableFunctionMethods,
      'generateChangeTo': enableChangeToMethods,
    };
  }
}
