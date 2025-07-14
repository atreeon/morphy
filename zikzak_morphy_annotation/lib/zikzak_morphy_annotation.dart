/// ZikZak Morphy Annotation - Annotations for code generation
///
/// This library provides annotations used by the ZikZak Morphy code generator
/// to create clean class definitions with advanced features.
///
/// The main annotations are:
/// - @Morphy() - Primary annotation for code generation
/// - @Morphy2() - Enhanced annotation with additional features
///
/// Usage:
/// ```dart
/// import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
///
/// @Morphy()
/// class User {
///   final String name;
///   final int age;
///
///   User({required this.name, required this.age});
/// }
/// ```
library zikzak_morphy_annotation;

// Export all annotations
export 'morphy_annotation.dart';
