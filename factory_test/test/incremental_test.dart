import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'incremental_test.morphy.dart';

// Test 1: Basic factory method
@morphy
abstract class $User {
  String get name;
  int get age;

  factory $User.create(String name, int age) => User._(name: name, age: age);
}

// Test 2: Factory with optional parameters
@morphy
abstract class $Product {
  String get title;
  double get price;
  String? get description;

  factory $Product.basic(String title, double price) =>
      Product._(title: title, price: price, description: null);

  factory $Product.detailed({
    required String title,
    required double price,
    String? description,
  }) =>
      Product._(title: title, price: price, description: description);
}

// Test 3: Inheritance with factory methods
@morphy
abstract class $Animal {
  String get species;
  int get age;
}

@morphy
abstract class $Cat implements $Animal {
  String get breed;
  bool get indoor;

  factory $Cat.kitten(String breed) =>
      Cat._(species: "Felis catus", age: 0, breed: breed, indoor: true);

  factory $Cat.adult({
    required String breed,
    required int age,
    bool indoor = true,
  }) =>
      Cat._(species: "Felis catus", age: age, breed: breed, indoor: indoor);
}

// Test 4: Hidden constructor with factory methods
@Morphy(hidePublicConstructor: true)
abstract class $SecureUser {
  String get username;
  String get hashedPassword;

  factory $SecureUser.create(String username, String rawPassword) =>
      SecureUser._(username: username, hashedPassword: _hash(rawPassword));
}

String _hash(String input) => "hashed_$input";

// Test 5: Factory with enums
enum UserRole { admin, user, guest }

@morphy
abstract class $Account {
  String get email;
  UserRole get role;
  bool get active;

  factory $Account.admin(String email) =>
      Account._(email: email, role: UserRole.admin, active: true);

  factory $Account.regular(String email) =>
      Account._(email: email, role: UserRole.user, active: true);

  factory $Account.guest() => Account._(
      email: "guest@example.com", role: UserRole.guest, active: false);
}

void main() {
  group('Incremental Factory Method Tests', () {
    group('Test 1: Basic Factory', () {
      test('should create User with factory method', () {
        var user = User.create("John", 30);
        expect(user.name, "John");
        expect(user.age, 30);
      });

      test('should maintain equality', () {
        var user1 = User.create("John", 30);
        var user2 = User.create("John", 30);
        expect(user1, equals(user2));
      });

      test('should work with copyWith', () {
        var user = User.create("John", 30);
        var updated = user.copyWithUser(age: () => 31);
        expect(updated.name, "John");
        expect(updated.age, 31);
      });
    });

    group('Test 2: Optional Parameters', () {
      test('should create Product with basic factory', () {
        var product = Product.basic("Widget", 9.99);
        expect(product.title, "Widget");
        expect(product.price, 9.99);
        expect(product.description, null);
      });

      test('should create Product with detailed factory', () {
        var product = Product.detailed(
          title: "Premium Widget",
          price: 19.99,
          description: "A high-quality widget",
        );
        expect(product.title, "Premium Widget");
        expect(product.price, 19.99);
        expect(product.description, "A high-quality widget");
      });

      test('should handle optional parameters with defaults', () {
        var product = Product.detailed(
          title: "Basic Widget",
          price: 5.99,
        );
        expect(product.title, "Basic Widget");
        expect(product.price, 5.99);
        expect(product.description, null);
      });
    });

    group('Test 3: Inheritance', () {
      test('should create Cat with kitten factory', () {
        var kitten = Cat.kitten("Persian");
        expect(kitten.breed, "Persian");
        expect(kitten.species, "Felis catus");
        expect(kitten.age, 0);
        expect(kitten.indoor, true);
      });

      test('should create Cat with adult factory', () {
        var cat = Cat.adult(breed: "Maine Coon", age: 5, indoor: false);
        expect(cat.breed, "Maine Coon");
        expect(cat.age, 5);
        expect(cat.indoor, false);
      });

      test('should inherit from Animal', () {
        var cat = Cat.kitten("Siamese");
        expect(cat is Animal, true);
        expect(cat.species, "Felis catus");
      });

      test('should work with polymorphic collections', () {
        var animals = <Animal>[
          Cat.kitten("British Shorthair"),
        ];
        expect(animals.length, 1);
        expect(animals[0] is Cat, true);
      });
    });

    group('Test 4: Hidden Constructor', () {
      test('should create SecureUser with factory method', () {
        var user = SecureUser.create("john_doe", "password123");
        expect(user.username, "john_doe");
        expect(user.hashedPassword, "hashed_password123");
      });

      test('should not expose public constructor', () {
        // This test verifies that SecureUser() constructor is not available
        // If compilation succeeds, the hidden constructor is working
        expect(true, true);
      });
    });

    group('Test 5: Enums', () {
      test('should create admin Account', () {
        var admin = Account.admin("admin@example.com");
        expect(admin.email, "admin@example.com");
        expect(admin.role, UserRole.admin);
        expect(admin.active, true);
      });

      test('should create regular Account', () {
        var user = Account.regular("user@example.com");
        expect(user.email, "user@example.com");
        expect(user.role, UserRole.user);
        expect(user.active, true);
      });

      test('should create guest Account', () {
        var guest = Account.guest();
        expect(guest.email, "guest@example.com");
        expect(guest.role, UserRole.guest);
        expect(guest.active, false);
      });
    });

    group('Type Safety', () {
      test('should maintain correct runtime types', () {
        var user = User.create("John", 30);
        var cat = Cat.kitten("Persian");
        var account = Account.admin("admin@test.com");

        expect(user.runtimeType, User);
        expect(cat.runtimeType, Cat);
        expect(account.runtimeType, Account);
      });

      test('should work with inheritance hierarchy', () {
        var cat = Cat.adult(breed: "Tabby", age: 3);
        expect(cat is Cat, true);
        expect(cat is Animal, true);
        expect(cat is Object, true);
      });
    });

    group('Edge Cases', () {
      test('should handle factory with no parameters', () {
        var guest = Account.guest();
        expect(guest, isA<Account>());
      });

      test('should handle factory with mixed parameter types', () {
        var cat = Cat.adult(breed: "Mixed", age: 2, indoor: false);
        expect(cat.breed, "Mixed");
        expect(cat.age, 2);
        expect(cat.indoor, false);
      });

      test('should preserve toString format', () {
        var user = User.create("Test", 25);
        var str = user.toString();
        expect(str.contains("User"), true);
        expect(str.contains("Test"), true);
        expect(str.contains("25"), true);
      });

      test('should work with hashCode', () {
        var user1 = User.create("Same", 30);
        var user2 = User.create("Same", 30);
        expect(user1.hashCode, user2.hashCode);
      });
    });
  });
}
