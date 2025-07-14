import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex58_copywith_nullable.morphy.dart';

//nullable types and copyWith

@Morphy(generateCopyWithFn: true)
abstract class $Pet {
  String? get type;

  String get name;
}

main() {
  test("1", () {
    var a = Pet(type: "cat", name: "bob");

    var expected = Pet(type: "cat", name: "bob");
    expect(a, expected);

    //set type to null
    var a_copy = a.copyWithPetFn(type: () => null);

    var expected2 = Pet(type: null, name: "bob");
    expect(a_copy, expected2);

    //copy just one param
    var a_copy3 = a.copyWithPetFn(name: () => "bobby");

    var expected3 = Pet(type: "cat", name: "bobby");
    expect(a_copy3, expected3);

    //set type to null initially
    var a4 = Pet(type: null, name: "bob");

    var expected4 = Pet(type: null, name: "bob");
    expect(a4, expected4);

    //type not specified
    var a5 = Pet(name: "bob");

    var expected5 = Pet(type: null, name: "bob");
    expect(a5, expected5);
  });
}
