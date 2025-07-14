import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'debug_factory_test.morphy.dart';

// Simple base class
@morphy
abstract class $Animal {
  String get species;
  int get age;
}

// Simple derived class with one factory method
@morphy
abstract class $Dog implements $Animal {
  String get breed;

  factory $Dog.puppy(String breed) =>
      Dog._(species: "Canis lupus", age: 0, breed: breed);
}

void main() {
  group('Debug Factory Test', () {
    test('should create Dog with puppy factory', () {
      var dog = Dog.puppy("Golden Retriever");
      expect(dog.breed, "Golden Retriever");
      expect(dog.species, "Canis lupus");
      expect(dog.age, 0);
    });
  });
}
