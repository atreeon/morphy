import 'common/NameType.dart';
import 'generators/method_generator_facade.dart';
import 'generators/method_generator_commons.dart';

// Re-export utilities for backward compatibility
export 'generators/method_generator_commons.dart'
    show NameCleaner, FieldTypeAnalyzer;

/// Backward compatibility wrapper for the original MethodGenerator
/// Now delegates to the new modular generators
class MethodGenerator {
  /// Generate copyWith methods (now generates simple copyWith without patchInput)
  /// AND separate patchWith methods
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

    // Generate simple copyWith methods (without patchInput)
    final copyWithMethods = MethodGeneratorFacade.generateCopyWithMethods(
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

    // Generate separate patchWith methods (with patchInput)
    final patchWithMethods = MethodGeneratorFacade.generatePatchWithMethods(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      generatePatchWithFn: generateCopyWithFn, // Use same flag for consistency
      knownClasses: knownClasses,
    );

    if (patchWithMethods.isNotEmpty) {
      methods.add(patchWithMethods);
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
  }) {
    return MethodGeneratorFacade.generateChangeToMethods(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      knownClasses: knownClasses,
      isInterfaceSealed: isInterfaceSealed,
    );
  }

  /// Generate abstract copyWith methods (now includes both copyWith and patchWith signatures)
  static String generateAbstractCopyWithMethods({
    required List<NameType> interfaceFields,
    required String interfaceName,
    required List<NameType> interfaceGenerics,
    bool generateCopyWithFn = false,
  }) {
    return MethodGeneratorFacade.generateAbstractCopyWithMethods(
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      interfaceGenerics: interfaceGenerics,
      generateCopyWithFn: generateCopyWithFn,
      generatePatchWithFn:
          generateCopyWithFn, // Include patchWith signatures too
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
    List<String> knownClasses = const [],
    bool isInterfaceSealed = false,
  }) {
    return MethodGeneratorFacade.generateAllMethods(
      classFields: classFields,
      interfaceFields: interfaceFields,
      interfaceName: interfaceName,
      className: className,
      isClassAbstract: isClassAbstract,
      interfaceGenerics: interfaceGenerics,
      generateCopyWithFn: generateCopyWithFn,
      generatePatchWithFn: generateCopyWithFn,
      generateChangeToFn: generateCopyWithFn,
      knownClasses: knownClasses,
      isInterfaceSealed: isInterfaceSealed,
    );
  }

  /// Generate methods for multiple interfaces
  static String generateMultipleInterfaceMethods({
    required List<NameType> classFields,
    required Map<String, List<NameType>> interfaceFieldsMap,
    required Map<String, List<NameType>> interfaceGenericsMap,
    required String className,
    required bool isClassAbstract,
    bool generateCopyWithFn = false,
    List<String> knownClasses = const [],
    Map<String, bool> interfaceSealedMap = const {},
  }) {
    return MethodGeneratorFacade.generateMultipleInterfaceMethods(
      classFields: classFields,
      interfaceFieldsMap: interfaceFieldsMap,
      interfaceGenericsMap: interfaceGenericsMap,
      className: className,
      isClassAbstract: isClassAbstract,
      generateCopyWithFn: generateCopyWithFn,
      generatePatchWithFn: generateCopyWithFn,
      knownClasses: knownClasses,
      interfaceSealedMap: interfaceSealedMap,
    );
  }

  /// Generate class-specific methods (for the class's own fields)
  static String generateClassMethods({
    required List<NameType> classFields,
    required String className,
    required List<NameType> classGenerics,
    List<String> knownClasses = const [],
  }) {
    return MethodGeneratorFacade.generateClassMethods(
      classFields: classFields,
      className: className,
      classGenerics: classGenerics,
      knownClasses: knownClasses,
    );
  }

  /// Check if methods should be generated
  static bool shouldGenerateMethods({
    required String interfaceName,
    required bool isClassAbstract,
    bool isInterfaceSealed = false,
  }) {
    return MethodGeneratorFacade.shouldGenerateMethods(
      interfaceName: interfaceName,
      isClassAbstract: isClassAbstract,
      isInterfaceSealed: isInterfaceSealed,
    );
  }
}

// Legacy constants for backward compatibility
const List<String> PRIMITIVE_TYPES = MethodGeneratorCommons.PRIMITIVE_TYPES;

String getPatchType(String baseType) {
  return MethodGeneratorCommons.getPatchType(baseType);
}
