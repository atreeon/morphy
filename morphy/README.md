# morphy
morphy is a code generation tool that can create copyWith, equals, toString, contructors and json to & from.
It's a bit like freezed or built_value but inheritance is allowed and polymorphism supported with copyWith and json.

### Reasoning:
We need a way to simplify our Dart classes, support polymorphism and allow copying and changing our classes.

### Why Not Freezed or Built Value?
Well the main reason; I actually wrote this before Freezed was released.
Freezed is really good, established and well used.
However if you want to use both inheritance and polymorphism use Morphy.

### Solution: use morphy

## Simple Example
To create a new class.
1. add the package morphy_annotation to the dependencies and the package morphy and build_runner to the dev dependencies
```
    dart pub add morphy_annotation
    dart pub add --dev morphy
    dart pub add --dev build_runner
```
2. copy and paste the following code into a new dart file:
   ```
    import 'package:morphy_annotation/morphy_annotation.dart';
    part 'Pet.morphy.dart';

    @morphy
    abstract class $Pet {
      String get type;
    }
    ```

3. run the build_runner
```
    dart run build_runner build
```

and that's it!  You can then create your objects!

```
   var cat = Pet(type: "cat");
```

`$Pet` is the class definition name. The generated class, the one you use to create objects, will drop the dollar, ie `Pet`.

### Rules

As in the simplest example above, `morphy` class definitions must
1. start with a dollar (the generated class removes the dollar)
2. be made abstract (the generated class is not made abstract, details below on how to make classes abstract)
3. have the @morphy annotation added directly to the class name
4. have the part file added to the top of the file, ie `part 'Pet.morphy.dart';`
5. import the morphy_annotation package, ie `import 'package:morphy_annotation/morphy_annotation.dart';`
6. and all properties must be defined as getters, ie `String get type;`

## Basic features (comes with every class)

### Equality (and hashCode)

Morphy supports deep equality out of the box.

```
var cat1 = Pet(type: "cat");
var cat2 = Pet(type: "cat");

expect(cat1 == cat2, true);
```

### A constructor is created for each class

All fields are required, non nullable and final by default

```
var cat1 = Pet(type: "cat");
```

### CopyWith

A simple copy with implementation comes with every class.
We pass a function to the copyWithPet method that returns a new value to set the property.
You can pass any value you like, including null if the property is nullable.

```
    var flossy = Pet(name: "Flossy", age: 5);
    var plossy = flossy.copyWithPet(name: () => "Plossy");

    expect(flossy.age, plossy.age);
```

### ToString

A default toString implementation is also included.

```
    var flossy = Pet(name: "Flossy", age: 5);

    expect(flossy.toString(), "(Pet-name:Flossy|age:5)");
```

### Inheritance

You can inherit one morphy class from another - use the implements keyword and the class definition name (the one with the dollar).
All properties will be inherited by default.

    @morphy
    abstract class $Cat implements $Pet {
      int get whiskerLength;
    }

    var bagpussCat = Cat(whiskerLength: 13.75, name: "Bagpuss", age: 4);

    expect(bagpussCat.whiskerLength, 13.75);

### CopyWith Polymorphic

Unlike other copy with implementations, morphy works on subclasses within the same file.
For example if you have a list of Person objects of which some are subtypes (Managers and Employees)
then the copyWith still works whilst preserving the underlying type.

    var pets = [
      Cat(whiskerLength: 13.75, name: "Bagpuss", age: 4),
      Dog(woofSound: "rowf", name: "Colin", age: 4),
    ];

    var petsOlder = pets //
        .map((e) => e.copyWithPet(age: () => e.age + 1))
        .toList();

    expect(petsOlder[0].age, 5);
    expect(petsOlder[1].age, 5);

Importantly the type remains the same, it is not converted to a Pet class.

    expect(petsOlder[0].runtimeType, Cat);
    expect(petsOlder[1].runtimeType, Dog);

### Enums are allowed

    @morphy
    abstract class $Fish implements $Pet {
      eFishColour get fishColour;
    }

    var goldie = Fish(fishColour: eFishColour.gold, name: "Goldie", age: 2);
    expect(goldie.fishColour, eFishColour.gold);

### Generics are allowed

Specify the class definition if you want to constrain your generic type (use the dollar)

    @morphy
    abstract class $PetOwner<TPet extends $Pet> {
      String get ownerName;
      TPet get pet;
    }

    var cathy = PetOwner<Cat>(ownerName: "Cathy", pet: bagpussCat);
    var dougie = PetOwner<Dog>(ownerName: "Dougie", pet: colin);

    expect(cathy.pet.whiskerLength, 13.75);
    expect(dougie.pet.woofSound, "rowf");

### ChangeTo

Sometimes you might want to turn a super class into a subclass (Pet into a Cat)

    var flossy = Pet(name: "Flossy", age: 5);

    var bagpussCat = flossy.changeToCat(whiskerLength: 13.75);

    expect(bagpussCat.whiskerLength, 13.75);
    expect(bagpussCat.runtimeType, Cat);

(subclass to super and sibling to sibling may also work.  A later release will iron out any edge cases)

### Convert object to Json

In order to convert the object to Json specify the `generateJson`.

    @Morphy(generateJson: true)
    abstract class $Pet {

Add the dev dependency to the json_serializable package

    dart pub add json_serializable --dev

Add the part file, .g is required by the json_serializable package used internally by `morphy`

    part 'Pets.g.dart';
    part 'Pets.morphy.dart';

Build the generated files then use the toJsonCustom method to generate the JSON

    var json = flossy.toJsonCustom({});
    expect(json, {'name': 'Flossy', 'age': 5, '_className_': 'Pet'});

### Convert Json to Object

Use the factory method `Pet.fromJson()` to create the new object.

    var json = {'name': 'Flossy', 'age': 5, '_className_': 'Pet'};

    var flossyFromJson = Pet.fromJson(json);
    var flossy = Pet(name: "Flossy", age: 5);

    expect(flossyFromJson == flossy, true);

### Json to Object Polymorphism

Unlike other json conversions you can convert subtypes using the super types toJson and fromJson functions.

The subtypes must be specified in the explicitSubTypes and in the correct order for this to work.

    @Morphy(generateJson: true, explicitSubTypes: [$Z, $Y])
    abstract class $X {
      String get val;
    }

    @Morphy(generateJson: true, explicitSubTypes: [$Z])
    abstract class $Y implements $X {
      int get valY;
    }

    @Morphy(generateJson: true)
    abstract class $Z implements $Y {
      double get valZ;
    }

    var xObjects = [
      X(val: "x"),
      Y(val: "xy", valY: 1),
      Z(val: "xyz", valY: 2, valZ: 4.34),
    ];

We can then just convert our list of X objects to JSON preserving their original type.

    var resultInJsonFormat = xObjects.map((e) => e.toJsonCustom({})).toList();

    var expectedJson = [
      {'val': 'x', '_className_': 'X'},
      {'val': 'xy', 'valY': 1, '_className_': 'Y'},
      {'val': 'xyz', 'valY': 2, 'valZ': 4.34, '_className_': 'Z'}
    ];

    expect(resultInJsonFormat, expectedJson);

and then convert them back again, continuing to preserve their original type

    var resultXObjects = expectedJson.map((e) => X.fromJson(e)).toList();

    expect(resultXObjects, xObjects);

Also generics work and more complicated inheritance hierarchies. (see the tests ex52 in the example folder)

### Multiple Inheritance

We also allow multiple inheritance.

    @Morphy(generateJson: true)
    abstract class $FrankensteinsDogCat implements $Dog, $Cat {}

    var frankie = FrankensteinsDogCat(whiskerLength: 13.75, woofSound: "rowf", name: "frankie", age: 1);

    expect(frankie is Cat, true);
    expect(frankie is Dog, true);

### Factory Methods

You can define factory methods directly in your abstract class definition. This provides a clean, idiomatic way to create named constructors without manual factory functions.

```dart
@morphy
abstract class $Person {
  String? get firstName;
  String? get lastName;
  int? get age;

  factory $Person.fromNames({
    required String firstName,
    required String lastName,
  }) => Person._(firstName: firstName, lastName: lastName, age: null);

  factory $Person.withAge(String firstName, String lastName, int age) =>
      Person._(firstName: firstName, lastName: lastName, age: age);

  factory $Person.empty() =>
      Person._(firstName: null, lastName: null, age: null);
}
```

This generates clean factory constructors in the concrete class:

```dart
var person1 = Person.fromNames(firstName: "John", lastName: "Doe");
var person2 = Person.withAge("Jane", "Smith", 30);
var person3 = Person.empty();
```

**Key Features:**
- Factory methods are automatically transformed from `$Person.fromNames` to `Person.fromNames`
- Parameters and body are preserved and transformed appropriately
- Full type safety and IntelliSense support
- Works with inheritance and polymorphism
- No manual boilerplate required

### Custom Constructors (Legacy Approach)

You can also use the legacy approach with factory functions. To hide the automatic constructor set the `hidePublicConstructor` on the Morphy annotation to true.

    @Morphy(hidePublicConstructor: true)
    abstract class $A {
      String get val;
      DateTime get timestamp;
    }

    A A_FactoryFunction(String val) {
      return A._(val: val, timestamp: DateTime(2023, 11, 25));
    }

    var a = A_FactoryFunction("my value");

    expect(a.timestamp, DateTime(2023, 11, 25));

### Optional Parameters

Optional parameters can be specified using the ? keyword on the getter property.

    @morphy
    abstract class $B {
      String get val;
      String? get optional;
    }

    var b = B(val: "5");

    expect(b.optional, null);

### Comments

Comments are copied from the class definition to the generated class
and for ease of use copied to the constructor too.

### Constant Constructor

Just define a blank const constructor in your class definition file

    const $A();

Then call the const constructor using the named constructor ```constant``

    var a = A.constant();

### Private Getters

Sometimes a private getter and public setter is useful for calculated properties.
If we start our property with an underscore then we make the getter private but continue to allow the property to be set.

      @morphy
      abstract class $$Pet {
         int get _ageInYears;

         String get name;
      }

      @morphy
      abstract class $Cat implements $$Pet {}

      @morphy
      abstract class $Dog implements $$Pet {}

      extension PetE on Pet {
         int age() => switch (this) {
            Cat() => _ageInYears * 7,
            Dog() => _ageInYears * 5,
         };
      }

       var cat = Cat(name: "Tom", ageInYears: 3);
       var dog = Dog(name: "Rex", ageInYears: 3);

       expect(cat.age(), 21);
       expect(dog.age(), 15);

### Patch System

Morphy generates a powerful patch system for each class that allows for flexible object manipulation and change tracking.

#### Basic Patch Usage

Every generated class comes with a corresponding `Patch` class:

```dart
@morphy
abstract class $User {
  String get name;
  int get age;
  String? get email;
}

// Generated patch class: UserPatch
var patch = UserPatch()
  ..withName("John")
  ..withAge(25);

var user = User(name: "Jane", age: 20, email: null);
var updatedUser = patch.applyTo(user);
// Result: User(name: "John", age: 25, email: null)
```

#### Patch Features

**1. Create patches from differences:**
```dart
var user1 = User(name: "John", age: 25, email: "john@example.com");
var user2 = User(name: "John", age: 30, email: "john@newdomain.com");

var diff = user1.compareToUser(user2);
// diff contains only the changed fields
```

**2. Create patches from maps:**
```dart
var patch = UserPatch.create({
  'name': 'Alice',
  'age': 28
});
```

**3. JSON serialization:**
```dart
var patch = UserPatch()..withName("Bob")..withAge(35);
var json = patch.toJson(); // {'name': 'Bob', 'age': 35}
var restored = UserPatch.fromJson(json);
```

**4. Chain patches:**
```dart
var user = User(name: "Start", age: 20, email: null);
var result = user
  .copyWithUser(name: () => "Middle")
  .copyWithUser(age: () => 25)
  .copyWithUser(email: () => "final@example.com");
```

#### Use Cases

- **State Management**: Track and apply incremental changes
- **API Updates**: Send only changed fields to backend
- **Undo/Redo**: Store patches for reversible operations
- **Form Handling**: Apply form changes without rebuilding entire objects
- **Change Tracking**: Compare object states and generate diffs

### Other

Self referencing classes are allowed.

Overriding properties with a sub type in a subclass is allowed.

If you need to navigate back to the class definition (not the generated code) it is
a kind of two step route back.  You must go to the generated and then you can click on the
$ version of the class which will be next to it.

Sometimes one class needs to be built before another.
In that scenario use morphy2 as the annotation in one class and morphy in the other.
