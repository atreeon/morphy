import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex4_inheritance_test.morphy.dart';

//ONLY USE IMPLEMENTS, EXTENDS IS NOT ALLOWED

@morphy
abstract class $$Z {
  String get zValue;
}

@morphy
abstract class $A implements $$Z {
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
    var a = A(aValue: "A", zValue: "Z");
    expect(a.aValue, "A");
    expect(a.zValue, "Z");

    var b = B(aValue: "A", bValue: "B", zValue: "Z");
    expect(b.aValue, "A");
    expect(b.bValue, "B");
    expect(a.zValue, "Z");

    var c = C(aValue: "A", bValue: "B", cValue: "C", zValue: "Z");
    expect(c.aValue, "A");
    expect(c.bValue, "B");
    expect(c.cValue, "C");
    expect(a.zValue, "Z");
  });
}
