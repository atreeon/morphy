// ignore_for_file: unnecessary_cast
// ignore_for_file: unused_element

import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex57_change_to_parent_test.morphy.dart';

main() {
  test("1 toJson", () {
    var aList = [
      A(id: "1"),
      B(id: "2", blah: "sdf"),
      C(id: "3", xyz: "my custom"),
    ];

    var result = aList.map((e) => e.changeToA()).toList();

    final expected = [A(id: "1"), A(id: "2"), A(id: "3")];

    expect(result, expected);
  });
}

@Morphy(explicitSubTypes: [$B, $C])
abstract class $A {
  String get id;
}

@Morphy()
abstract class $B implements $A {
  String get blah;
}

@Morphy()
abstract class $C implements $A {
  String get xyz;
}
