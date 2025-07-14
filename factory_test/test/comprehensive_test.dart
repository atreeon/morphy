import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'comprehensive_test.g.dart';
part 'comprehensive_test.morphy.dart';

// Test all annotation fields
@Morphy(
  generateJson: true,
  explicitToJson: true,
  generateCompareTo: true,
  hidePublicConstructor: false,
  nonSealed: false,
)
abstract class $BasicUser {
  String get name;
  int get age;
  String? get email;

  factory $BasicUser.create(String name, int age) =>
      BasicUser._(name: name, age: age, email: null);

  factory $BasicUser.withEmail({
    required String name,
    required int age,
    required String email,
  }) => BasicUser._(name: name, age: age, email: email);
}

// Test hidePublicConstructor with factory methods
@Morphy(hidePublicConstructor: true, generateJson: false)
abstract class $PrivateUser {
  String get username;
  DateTime get createdAt;

  factory $PrivateUser.now(String username) =>
      PrivateUser._(username: username, createdAt: DateTime.now());

  factory $PrivateUser.withDate(String username, DateTime date) =>
      PrivateUser._(username: username, createdAt: date);
}

// Test sealed classes ($$-prefixed)
@Morphy(nonSealed: false)
abstract class $$Animal {
  String get species;
  int get lifespan;
}

// Test non-sealed abstract classes
@Morphy(nonSealed: true)
abstract class $$Vehicle {
  String get type;
  int get wheels;
}

// Test inheritance with factory methods
@morphy
abstract class $Dog implements $$Animal {
  String get breed;
  bool get isGoodBoy;

  factory $Dog.goodBoy(String breed) => Dog._(
    species: "Canis lupus",
    lifespan: 12,
    breed: breed,
    isGoodBoy: true,
  );

  factory $Dog.rescue({required String breed, int lifespan = 10}) => Dog._(
    species: "Canis lupus",
    lifespan: lifespan,
    breed: breed,
    isGoodBoy: true,
  );
}

// Test multiple inheritance with factory methods
@morphy
abstract class $ServiceDog implements $Dog {
  String get service;
  bool get isTrained;

  factory $ServiceDog.guide(String breed) => ServiceDog._(
    species: "Canis lupus",
    lifespan: 12,
    breed: breed,
    isGoodBoy: true,
    service: "guide",
    isTrained: true,
  );
}

@morphy
abstract class $Pet {
  String get type;
}

@morphy
abstract class $Cat implements $Pet {
  double get whiskerLength;

  factory $Cat.bagpuss(double whiskerLength) =>
      Cat._(type: "cat", whiskerLength: whiskerLength);
}

@morphy
abstract class $PetDog implements $Pet {
  String get woofSound;

  factory $PetDog.colin(String woofSound) =>
      PetDog._(type: "dog", woofSound: woofSound);
}

@morphy
abstract class $PetOwner<TPet extends $Pet> {
  String get ownerName;
  TPet get pet;

  factory $PetOwner.named(TPet pet, String name) =>
      PetOwner._(pet: pet, ownerName: name);
}

// Test with explicit subtypes
@Morphy(generateJson: true, explicitSubTypes: [$Manager, $Employee])
abstract class $Person {
  String get name;
  int get age;
  String? get department;

  factory $Person.basic(String name, int age) =>
      Person._(name: name, age: age, department: null);
}

@Morphy(generateJson: true)
abstract class $Employee implements $Person {
  double get salary;
  String get role;

  factory $Employee.intern(String name, int age, String department) =>
      Employee._(
        name: name,
        age: age,
        department: department,
        salary: 0.0,
        role: "intern",
      );

  factory $Employee.fullTime({
    required String name,
    required int age,
    required String department,
    required double salary,
    String role = "employee",
  }) => Employee._(
    name: name,
    age: age,
    department: department,
    salary: salary,
    role: role,
  );
}

@Morphy(generateJson: true)
abstract class $Manager implements $Employee {
  int get teamSize;
  List<String> get responsibilities;

  factory $Manager.senior({
    required String name,
    required int age,
    required String department,
    required double salary,
    required int teamSize,
    List<String> responsibilities = const [],
  }) => Manager._(
    name: name,
    age: age,
    department: department,
    salary: salary,
    role: "senior manager",
    teamSize: teamSize,
    responsibilities: responsibilities,
  );
}

// Test const constructor with factory methods
@morphy
abstract class $Config {
  String get environment;
  bool get debugMode;
  Map<String, String> get settings;

  const $Config();

  factory $Config.development() => Config._(
    environment: "development",
    debugMode: true,
    settings: {"debug": "true", "verbose": "true"},
  );

  factory $Config.production() => Config._(
    environment: "production",
    debugMode: false,
    settings: {"debug": "false", "verbose": "false"},
  );
}

// Test enums with factory methods
enum Priority { low, medium, high, critical }

@morphy
abstract class $Task {
  String get title;
  String get description;
  Priority get priority;
  DateTime? get dueDate;

  factory $Task.urgent(String title, String description) => Task._(
    title: title,
    description: description,
    priority: Priority.critical,
    dueDate: DateTime.now().add(Duration(hours: 1)),
  );

  factory $Task.normal({
    required String title,
    String description = "",
    Priority priority = Priority.medium,
  }) => Task._(
    title: title,
    description: description,
    priority: priority,
    dueDate: null,
  );
}

// Test self-referencing class with factory methods
@Morphy(generateJson: true)
abstract class $TreeNode {
  String get value;
  List<$TreeNode>? get children;
  $TreeNode? get parent;

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

void main() {
  group('Comprehensive Factory Method Tests', () {
    group('Basic Factory Methods', () {
      test('should create BasicUser with create factory', () {
        var user = BasicUser.create("John", 30);
        expect(user.name, "John");
        expect(user.age, 30);
        expect(user.email, null);
      });

      test('should create BasicUser with withEmail factory', () {
        var user = BasicUser.withEmail(
          name: "Jane",
          age: 25,
          email: "jane@example.com",
        );
        expect(user.name, "Jane");
        expect(user.age, 25);
        expect(user.email, "jane@example.com");
      });

      test('should work with copyWith', () {
        var user = BasicUser.create("John", 30);
        var updated = user.copyWithBasicUser(email: () => "john@example.com");
        expect(updated.email, "john@example.com");
        expect(updated.name, "John");
      });
    });

    group('Hidden Constructor Factory Methods', () {
      test('should create PrivateUser with now factory', () {
        var user = PrivateUser.now("testuser");
        expect(user.username, "testuser");
        expect(
          user.createdAt.isBefore(DateTime.now().add(Duration(seconds: 1))),
          true,
        );
      });

      test('should create PrivateUser with withDate factory', () {
        var date = DateTime(2023, 1, 1);
        var user = PrivateUser.withDate("testuser", date);
        expect(user.username, "testuser");
        expect(user.createdAt, date);
      });
    });

    group('Inheritance with Factory Methods', () {
      test('should create Dog with goodBoy factory', () {
        var dog = Dog.goodBoy("Golden Retriever");
        expect(dog.breed, "Golden Retriever");
        expect(dog.isGoodBoy, true);
        expect(dog.species, "Canis lupus");
        expect(dog.lifespan, 12);
      });

      test('should create Dog with rescue factory', () {
        var dog = Dog.rescue(breed: "Mixed", lifespan: 8);
        expect(dog.breed, "Mixed");
        expect(dog.lifespan, 8);
        expect(dog.isGoodBoy, true);
      });

      test('should create ServiceDog with guide factory', () {
        var serviceDog = ServiceDog.guide("German Shepherd");
        expect(serviceDog.breed, "German Shepherd");
        expect(serviceDog.service, "guide");
        expect(serviceDog.isTrained, true);
        expect(serviceDog.isGoodBoy, true);
      });
    });

    // group('Generics with Factory Methods', () {
    //   test('should create Container<String> with labeled factory', () {
    //     var container = Container<String>.labeled("Hello", "greeting");
    //     expect(container.item, "Hello");
    //     expect(container.label, "greeting");
    //   });

    //   test('should create Container<int> with unlabeled factory', () {
    //     var container = Container<int>.unlabeled(42);
    //     expect(container.item, 42);
    //     expect(container.label, "");
    //   });
    // });

    group('Explicit Subtypes with Factory Methods', () {
      test('should create Person with basic factory', () {
        var person = Person.basic("Alice", 30);
        expect(person.name, "Alice");
        expect(person.age, 30);
        expect(person.department, null);
      });

      test('should create Employee with intern factory', () {
        var employee = Employee.intern("Bob", 22, "Engineering");
        expect(employee.name, "Bob");
        expect(employee.age, 22);
        expect(employee.department, "Engineering");
        expect(employee.salary, 0.0);
        expect(employee.role, "intern");
      });

      test('should create Employee with fullTime factory', () {
        var employee = Employee.fullTime(
          name: "Carol",
          age: 28,
          department: "Sales",
          salary: 50000.0,
          role: "sales rep",
        );
        expect(employee.name, "Carol");
        expect(employee.salary, 50000.0);
        expect(employee.role, "sales rep");
      });

      test('should create Manager with senior factory', () {
        var manager = Manager.senior(
          name: "David",
          age: 35,
          department: "Engineering",
          salary: 100000.0,
          teamSize: 5,
          responsibilities: ["hiring", "planning"],
        );
        expect(manager.name, "David");
        expect(manager.teamSize, 5);
        expect(manager.responsibilities, ["hiring", "planning"]);
        expect(manager.role, "senior manager");
      });
    });

    group('Const Constructor with Factory Methods', () {
      test('should create Config with development factory', () {
        var config = Config.development();
        expect(config.environment, "development");
        expect(config.debugMode, true);
        expect(config.settings["debug"], "true");
      });

      test('should create Config with production factory', () {
        var config = Config.production();
        expect(config.environment, "production");
        expect(config.debugMode, false);
        expect(config.settings["debug"], "false");
      });

      test('should create Config with constant constructor', () {
        var config = Config.constant(
          environment: "test",
          debugMode: true,
          settings: {"test": "true"},
        );
        expect(config, isA<Config>());
      });
    });

    group('Enums with Factory Methods', () {
      test('should create Task with urgent factory', () {
        var task = Task.urgent("Fix bug", "Critical production issue");
        expect(task.title, "Fix bug");
        expect(task.description, "Critical production issue");
        expect(task.priority, Priority.critical);
        expect(task.dueDate, isNotNull);
      });

      test('should create Task with normal factory', () {
        var task = Task.normal(title: "Review code", priority: Priority.low);
        expect(task.title, "Review code");
        expect(task.description, "");
        expect(task.priority, Priority.low);
        expect(task.dueDate, null);
      });
    });

    group('Self-Referencing with Factory Methods', () {
      test('should create TreeNode with root factory', () {
        var root = TreeNode.root("root");
        expect(root.value, "root");
        expect(root.children, isEmpty);
        expect(root.parent, null);
      });

      test('should create TreeNode with leaf factory', () {
        var root = TreeNode.root("root");
        var leaf = TreeNode.leaf("leaf", root);
        expect(leaf.value, "leaf");
        expect(leaf.children, null);
        expect(leaf.parent, root);
      });

      test('should create TreeNode with branch factory', () {
        var root = TreeNode.root("root");
        var child1 = TreeNode.leaf("child1", root);
        var child2 = TreeNode.leaf("child2", root);
        var branch = TreeNode.branch("branch", root, [child1, child2]);
        expect(branch.value, "branch");
        expect(branch.children?.length, 2);
        expect(branch.parent, root);
      });
    });

    group('Type Safety and Polymorphism', () {
      test('factory methods should maintain correct types', () {
        var dog = Dog.goodBoy("Labrador");
        var serviceDog = ServiceDog.guide("German Shepherd");

        expect(dog.runtimeType, Dog);
        expect(serviceDog.runtimeType, ServiceDog);
        expect(serviceDog is Dog, true);
      });

      test('factory methods should work with polymorphic lists', () {
        var animals = <Animal>[Dog.goodBoy("Poodle")];

        expect(animals.length, 1);
        expect(animals[0] is Dog, true);
      });

      test('factory methods should preserve equality', () {
        var user1 = BasicUser.create("John", 30);
        var user2 = BasicUser.create("John", 30);
        expect(user1, equals(user2));
      });
    });

    group('Edge Cases', () {
      test('should handle factory methods with no parameters', () {
        var config = Config.development();
        expect(config, isA<Config>());
      });

      test('should handle factory methods with optional parameters', () {
        var task = Task.normal(title: "Test");
        expect(task.description, "");
        expect(task.priority, Priority.medium);
      });

      test('should handle factory methods with default values', () {
        var employee = Employee.fullTime(
          name: "Test",
          age: 25,
          department: "IT",
          salary: 50000.0,
        );
        expect(employee.role, "employee");
      });

      // test('should handle complex nested types', () {
      //   var container = Container<List<String>>.labeled(["a", "b"], "strings");
      //   expect(container.item, ["a", "b"]);
      //   expect(container.label, "strings");
      // });
    });

    group('Generic PetOwner with Factory Methods', () {
      test('should create PetOwner<Cat> with named factory', () {
        var bagpussCat = Cat.bagpuss(13.75);
        var cathy = PetOwner.named(bagpussCat, "Cathy");

        expect(cathy.pet.whiskerLength, 13.75);
        expect(cathy.ownerName, "Cathy");
        expect(cathy.pet.type, "cat");
      });

      test('should create PetOwner<PetDog> with named factory', () {
        var colin = PetDog.colin("rowf");
        var dougie = PetOwner.named(colin, "Dougie");

        expect(dougie.pet.woofSound, "rowf");
        expect(dougie.ownerName, "Dougie");
        expect(dougie.pet.type, "dog");
      });

      test('should maintain generic type safety', () {
        var cat = Cat.bagpuss(10.5);
        var dog = PetDog.colin("woof");

        var catOwner = PetOwner.named(cat, "Alice");
        var dogOwner = PetOwner.named(dog, "Bob");

        expect(catOwner.pet.runtimeType, Cat);
        expect(dogOwner.pet.runtimeType, PetDog);
        expect(catOwner.pet is Cat, true);
        expect(dogOwner.pet is PetDog, true);
      });
    });
  });
}
