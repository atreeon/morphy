/// ZikZak Morphy - A powerful code generation package for Dart/Flutter
///
/// Provides clean class definitions with copyWith, JSON serialization,
/// toString, equality, and inheritance support.
///
/// This package generates boilerplate code for immutable data classes
/// with advanced features like:
/// - Type-safe copyWith methods with inheritance support
/// - JSON serialization/deserialization
/// - Automatic toString and equality implementations
/// - Patch-based updates for complex objects
/// - changeTo methods for type transformations
///
/// Usage:
/// 1. Add annotations to your classes using @Morphy() or @Morphy2()
/// 2. Run `dart run build_runner build` to generate code
/// 3. Use the generated methods in your application
library zikzak_morphy;

// Export the main annotation
export 'package:zikzak_morphy_annotation/morphy_annotation.dart';
