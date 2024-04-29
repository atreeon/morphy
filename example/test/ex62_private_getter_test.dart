import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex62_private_getter_test.morphy.dart';

//nullable private getters and private morphy class

main() {
  test("1", () {
    var cat = Cat(
      name: "Tom",
      ageInYears: 3,
      owner: Owner(name: "Jerry"),
    );
    var dog = Dog(name: "Rex", ageInYears: 3);

    expect(cat.age(), 21);
    expect(dog.age(), 15);
  });
}

extension Pet_E on $$Pet {
  int age() => switch (this) {
        Cat() => (_ageInYears ?? 1) * 7,
        Dog() => (_ageInYears ?? 1) * 5,
        _ => throw "Not implemented",
      };
}

@morphy
abstract class $Owner {
  String get name;
}

@morphy
abstract class $$Pet {
  int? get _ageInYears;

  String get name;
}

@morphy
abstract class $Cat implements $$Pet {
  $Owner get _owner;
}

@morphy
abstract class $Dog implements $$Pet {}
