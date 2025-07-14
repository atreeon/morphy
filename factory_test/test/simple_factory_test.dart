import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'simple_factory_test.morphy.dart';
part 'simple_factory_test.g.dart';

@Morphy(generateJson: true, generateCopyWithFn: true)
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

void main() {
  group('Factory Method Tests', () {
    test('should create Person using fromNames factory', () {
      var person = Person.fromNames(firstName: "John", lastName: "Doe");

      expect(person.firstName, "John");
      expect(person.lastName, "Doe");
      expect(person.age, null);
    });

    test('should create Person using withAge factory', () {
      var person = Person.withAge("Jane", "Smith", 30);

      expect(person.firstName, "Jane");
      expect(person.lastName, "Smith");
      expect(person.age, 30);
    });

    test('should create empty Person using empty factory', () {
      var person = Person.empty();

      expect(person.firstName, null);
      expect(person.lastName, null);
      expect(person.age, null);
    });

    test('factory methods should maintain type equality', () {
      var person1 = Person.fromNames(firstName: "John", lastName: "Doe");
      var person2 = Person.fromNames(firstName: "John", lastName: "Doe");

      expect(person1, equals(person2));
      expect(person1.runtimeType, Person);
    });

    test('factory methods should work with copyWith', () {
      var person = Person.fromNames(firstName: "John", lastName: "Doe");
      var aged = person.copyWithPersonFn(age: () => 25);

      expect(aged.firstName, "John");
      expect(aged.lastName, "Doe");
      expect(aged.age, 25);
    });
  });
}
