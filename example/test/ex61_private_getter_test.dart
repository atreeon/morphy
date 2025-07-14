import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex61_private_getter_test.morphy.dart';

//shows the private getter stuff

main() {
  test("1", () {
    var cat = Cat(name: "Tom", ageInYears: 3);
    var dog = Dog(name: "Rex", ageInYears: 3);

    expect(cat.age(), 21);
    expect(dog.age(), 15);
  });
}

extension Pet_E on Pet {
  int age() => switch (this) {
    Cat() => _ageInYears * 7,
    Dog() => _ageInYears * 5,
  };
}

@morphy
abstract class $$Pet {
  int get _ageInYears;

  String get name;
}

@morphy
abstract class $Cat implements $$Pet {}

@morphy
abstract class $Dog implements $$Pet {}
