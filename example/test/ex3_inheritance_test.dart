import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex3_inheritance_test.morphy.dart';

//INTERFACES ARE AUTO IMPLEMENTED

@morphy
abstract class $A {
  String get aValue;
}

@morphy
abstract class $B implements $A {
  String get bValue;
}

@morphy
abstract class $C implements $B {
  String get cValue;
}

main() {
  test("1", () {
    var a = A(aValue: "A");
    expect(a.aValue, "A");

    var b = B(aValue: "A", bValue: "B");
    expect(b.aValue, "A");
    expect(b.bValue, "B");

    var c = C(aValue: "A", bValue: "B", cValue: "C");
    expect(c.aValue, "A");
    expect(c.bValue, "B");
    expect(c.cValue, "C");
  });
}
