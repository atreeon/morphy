# ZikZak Morphy Annotation

Annotations package for the ZikZak Morphy code generation system. This package provides the core annotations used to generate clean class definitions with advanced features.

## Overview

ZikZak Morphy Annotation is the companion package to ZikZak Morphy that contains all the annotations needed for code generation. It provides a clean, type-safe way to mark classes for automatic generation of boilerplate code.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  zikzak_morphy_annotation: ^2.0.0

dev_dependencies:
  zikzak_morphy: ^2.0.0
  build_runner: ^2.5.4
```

## Annotations

### @Morphy()

The primary annotation for code generation. Use this to mark classes that should have boilerplate code generated.

```dart
import 'package:zikzak_morphy_annotation/zikzak_morphy_annotation.dart';

@Morphy()
class User {
  final String name;
  final int age;
  final String? email;
  
  User({
    required this.name,
    required this.age,
    this.email,
  });
}
```

#### Configuration Options

```dart
@Morphy(
  generateToJson: true,        // Generate JSON serialization
  generateFromJson: true,      // Generate JSON deserialization
  generateCopyWith: true,      // Generate copyWith methods
  generateEquality: true,      // Generate equality operators
  generateToString: true,      // Generate toString methods
  generateHashCode: true,      // Generate hashCode methods
  generatePatch: true,         // Generate patch classes
  hidePublicConstructor: false, // Hide the public constructor
)
class MyClass {
  // Your fields here
}
```

### @Morphy2()

Enhanced annotation with additional features for complex scenarios:

```dart
@Morphy2(
  // All Morphy options plus:
  enableFactoryMethods: true,  // Generate factory methods
  customToString: true,        // Custom toString implementation
  inheritanceSupport: true,    // Enhanced inheritance features
)
class AdvancedClass {
  // Your fields here
}
```

## Generated Code Features

When you annotate a class with `@Morphy()`, the following code is automatically generated:

### CopyWith Methods
Type-safe copying with optional parameter overrides:
```dart
User copyWithUser({String? name, int? age, String? email});
```

### JSON Serialization
Automatic JSON conversion:
```dart
Map<String, dynamic> toJson();
static User fromJson(Map<String, dynamic> json);
```

### Equality and HashCode
Value-based equality comparison:
```dart
bool operator ==(Object other);
int get hashCode;
```

### ToString
Human-readable string representation:
```dart
String toString(); // Returns: (User-name:John|age:30|email:null)
```

### Patch Classes
For complex object updates:
```dart
class UserPatch {
  UserPatch withName(String name);
  UserPatch withAge(int age);
  UserPatch withEmail(String? email);
}
```

### Inheritance Support

For classes with inheritance, additional methods are generated:

```dart
// Transform between related classes
Manager changeToManager({required int teamSize, ...});
Employee changeToEmployee({required double salary, ...});

// Copy with inheritance hierarchy support
User copyWithPerson({String? name, int? age});
Manager copyWithManager({int? teamSize, ...});
```

## Advanced Usage

### Abstract Classes and Interfaces

```dart
@Morphy()
abstract class Animal {
  final String species;
  final int lifespan;
}

@Morphy()
class Dog extends Animal {
  final String breed;
  final bool isGoodBoy;
}
```

### Generic Classes

```dart
@Morphy()
class Container<T> {
  final T value;
  final String label;
  
  Container({required this.value, required this.label});
}
```

### Private Fields

```dart
@Morphy()
class SecureUser {
  final String name;
  final String _password;  // Private field with generated getter
  
  String get password => _password;
}
```

## Code Generation

After annotating your classes, run the code generator:

```bash
dart run build_runner build
```

This will create `.morphy.dart` files containing all the generated code.

## Build Configuration

Create a `build.yaml` file in your project root:

```yaml
targets:
  $default:
    builders:
      zikzak_morphy|morphy:
        enabled: true
```

## Integration with Other Packages

ZikZak Morphy Annotation works seamlessly with:

- **json_annotation**: Automatic integration for JSON serialization
- **equatable**: Can be used alongside for additional equality features
- **freezed**: Compatible for mixed usage scenarios
- **built_value**: Can coexist in the same project

## Best Practices

### Naming Conventions
- Use PascalCase for class names
- Use camelCase for field names
- Prefix abstract classes with descriptive names

### Field Design
```dart
@Morphy()
class GoodExample {
  final String name;           // Required non-nullable
  final int? age;             // Optional nullable
  final List<String> tags;    // Required collection
  final DateTime createdAt;   // Required complex type
}
```

### Inheritance Hierarchies
```dart
@Morphy()
abstract class BaseEntity {
  final String id;
  final DateTime createdAt;
}

@Morphy()
class User extends BaseEntity {
  final String name;
  final String email;
}

@Morphy()
class AdminUser extends User {
  final List<String> permissions;
  final bool isSuperAdmin;
}
```

## Error Handling

Common issues and solutions:

### Missing Dependencies
```
Error: Could not find package 'zikzak_morphy_annotation'
```
Solution: Add the annotation package to your `dependencies` in `pubspec.yaml`

### Build Failures
```
Error: Part file not found
```
Solution: Run `dart run build_runner build --delete-conflicting-outputs`

### Type Errors
```
Error: The argument type 'X' can't be assigned to parameter type 'Y'
```
Solution: Check that all required fields are properly typed and non-nullable where appropriate

## Migration from Original Morphy

If migrating from the original morphy_annotation package:

1. Update import statements:
```dart
// Old
import 'package:morphy_annotation/morphy_annotation.dart';

// New
import 'package:zikzak_morphy_annotation/zikzak_morphy_annotation.dart';
```

2. Update build configuration in `build.yaml`:
```yaml
# Old
builders:
  morphy|morphy:

# New  
builders:
  zikzak_morphy|morphy:
```

3. Regenerate all code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Credits

This package builds upon the foundational work of the original [Morphy package](https://pub.dev/packages/morphy) by [@atreon](https://github.com/atreon). We acknowledge and appreciate the innovative architecture that made this enhanced version possible.

## License

This project is licensed under the MIT License - see the LICENSE file for details.