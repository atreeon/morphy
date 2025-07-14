import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex15_equality_test.morphy.dart';

//EQUALITY

@morphy
abstract class $A {
  String get a;
}

@morphy
abstract class $B implements $A {
  int get b;
}

@morphy
abstract class $C implements $B {
  bool get c;
}

main() {
  test("1", () {
    var a1 = A(a: "A");
    var a2 = A(a: "A");
    var a3 = A(a: "A3");

    expect(a1 == a2, true);
    expect(a1 == a3, false);

    var c1 = C(a: "C", b: 1, c: true);
    var c2 = C(a: "C", b: 1, c: true);
    var c3 = C(a: "C3", b: 1, c: true);

    expect(c1 == c2, true);
    expect(c1 == c3, false);
  });
}
