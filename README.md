# ZikZak Morphy

A powerful code generation package for Dart/Flutter that provides clean class definitions with advanced features including copyWith methods, JSON serialization, toString, equality, and comprehensive inheritance support.

## Package Structure

This repository contains two packages:

- **`zikzak_morphy/`** - Main code generation package
- **`zikzak_morphy_annotation/`** - Annotations package

## Installation

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  zikzak_morphy_annotation: ^2.0.0

dev_dependencies:
  zikzak_morphy: ^2.0.0
  build_runner: ^2.5.4
```

## Features

- **Type-safe copyWith methods** with full inheritance support
- **JSON serialization/deserialization** with automatic handling
- **Automatic toString and equality** implementations
- **Patch-based updates** for complex object modifications
- **changeTo methods** for type transformations between related classes
- **Multiple inheritance** support for interfaces
- **Generic type** handling
- **Private constructor** support
- **Clean architecture** patterns

## Quick Start

1. **Annotate your classes** with `@Morphy()`:

```dart
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'user.morphy.dart';

@Morphy()
abstract class $User {
  String get name;
  int get age;
  String? get email;
  
  // Factory methods for clean object creation
  factory $User.create(String name, int age) =>
      User._(name: name, age: age, email: null);

  factory $User.withEmail({
    required String name,
    required int age,
    required String email,
  }) => User._(name: name, age: age, email: email);
}
```

2. **Run code generation**:

```bash
dart run build_runner build
```

3. **Use the generated features**:

```dart
// Create instances using factory methods
final user = User.create('John', 30);
final emailUser = User.withEmail(
  name: 'Jane', 
  age: 25, 
  email: 'jane@example.com'
);

// Type-safe copyWith
final updatedUser = user.copyWithUser(age: () => 31);

// JSON serialization (when generateJson: true)
final json = user.toJson();
final fromJson = User.fromJson(json);

// Automatic toString and equality
print(user); // (User-name:John|age:30|email:null)
print(user == updatedUser); // false
```

## Advanced Features

### Factory Constructors

Define named constructors with custom logic directly in your abstract class:

```dart
@Morphy(hidePublicConstructor: true)
abstract class $Product {
  String get id;
  String get name;
  double get price;
  String get category;
  bool get isActive;

  // Factory with validation logic
  factory $Product.discounted({
    required String name,
    required double originalPrice,
    required double discountPercent,
  }) {
    final discountedPrice = originalPrice * (1 - discountPercent / 100);
    return Product._(
      id: 'DISC_${DateTime.now().millisecondsSinceEpoch}',
      name: '$name (${discountPercent.toInt()}% OFF)',
      price: discountedPrice,
      category: 'sale',
      isActive: true,
    );
  }

  // Factory from external data
  factory $Product.fromApi(Map<String, dynamic> apiData) {
    return Product._(
      id: apiData['product_id'] ?? '',
      name: apiData['display_name'] ?? 'Unknown',
      price: (apiData['price_cents'] ?? 0) / 100.0,
      category: apiData['category'] ?? 'general',
      isActive: apiData['status'] == 'active',
    );
  }
}

// Usage
var saleProduct = Product.discounted(
  name: "Premium Widget",
  originalPrice: 100.0,
  discountPercent: 25.0,
);

var apiProduct = Product.fromApi({
  'product_id': 'PROD123',
  'display_name': 'API Widget',
  'price_cents': 2500,
  'status': 'active',
});
```

### Self-Referencing Classes

Handle complex tree structures and hierarchical data:

```dart
@Morphy(generateJson: true)
abstract class $TreeNode {
  String get value;
  List<$TreeNode>? get children;
  $TreeNode? get parent;

  // Factory methods for different node types
  factory $TreeNode.root(String value) =>
      TreeNode._(value: value, children: [], parent: null);

  factory $TreeNode.leaf(String value, TreeNode parent) =>
      TreeNode._(value: value, children: null, parent: parent);

  factory $TreeNode.branch(
    String value,
    TreeNode parent,
    List<TreeNode> children,
  ) => TreeNode._(value: value, children: children, parent: parent);
}

// Build a file system tree
var rootDir = TreeNode.root("/");
var homeDir = TreeNode.leaf("home", rootDir);
var userDir = TreeNode.leaf("john", homeDir);

// Navigate and modify
var updatedRoot = rootDir.copyWithTreeNode(
  children: () => [homeDir, TreeNode.leaf("tmp", rootDir)]
);
```

### Type Transformations

Transform between related classes in inheritance hierarchies:

```dart
@Morphy(generateJson: true)
abstract class $Person {
  String get name;
  int get age;
  String? get department;
}

@Morphy(generateJson: true)
abstract class $Manager extends $Person {
  int get teamSize;
  List<String> get responsibilities;
  double get salary;
  String get role;
}

// Transform Person to Manager (demonstrates our changeTo fix)
final person = Person.basic('Alice', 35, 'Engineering');
final manager = person.changeToManager(
  teamSize: 10,
  responsibilities: ['Planning', 'Development'],
  salary: 120000.0,
  role: 'Tech Lead',
);
```

## Key Improvements

This enhanced version fixes critical issues in the original Morphy package:

- **Fixed changeTo method generation** - No longer attempts to access non-existent fields on source classes
- **Enhanced type safety** - Proper handling of inheritance hierarchies
- **Improved patch system** - Better null safety and error handling
- **Clean architecture support** - Designed for modern Flutter development patterns

## Documentation

For detailed documentation, examples, and API reference, see the individual package README files:

- [ZikZak Morphy Package](./zikzak_morphy/README.md)
- [ZikZak Morphy Annotation Package](./zikzak_morphy_annotation/README.md)

## Testing

The `factory_test/` directory contains comprehensive tests demonstrating all package features and ensuring code generation works correctly.

## Credits

This package is based on the excellent work from the original [Morphy package](https://pub.dev/packages/morphy) by [@atreon](https://github.com/atreon). We extend our gratitude for the foundational architecture and innovative approach to Dart code generation.

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.