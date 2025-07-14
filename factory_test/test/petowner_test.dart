import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'petowner_test.morphy.dart';

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

void main() {
  group('PetOwner Factory Method Tests', () {
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

    test('should work with copyWith methods', () {
      var cat = Cat.bagpuss(10.5);
      var catOwner = PetOwner.named(cat, "Alice");

      var updatedOwner = catOwner.copyWithPetOwner(ownerName: "Bob");
      expect(updatedOwner.ownerName, "Bob");
      expect(updatedOwner.pet, cat); // pet should remain the same
    });

    test('should work with polymorphic usage', () {
      var cat = Cat.bagpuss(12.0);
      var dog = PetDog.colin("bark");

      var catOwner = PetOwner.named(cat, "CatOwner");
      var dogOwner = PetOwner.named(dog, "DogOwner");

      // Test that they can be treated polymorphically
      var owners = [catOwner, dogOwner];
      expect(owners.length, 2);
      expect(owners[0].ownerName, "CatOwner");
      expect(owners[1].ownerName, "DogOwner");
    });
  });
}
