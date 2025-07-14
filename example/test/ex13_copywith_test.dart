import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex13_copywith_test.morphy.dart';
// part 'ex13_copywith_test.morphy_manual.dart';

// ignore_for_file: UNNECESSARY_CAST

//COPY WITH

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
    var a = A(a: "A");
    var b = B(a: "A", b: 1);
    var c = C(a: "A", b: 1, c: true);

    var a1 = a.copyWithA(a: () => "Aa1");
    expect(a1.a, "Aa1");

    var b1 = b.copyWithA(a: () => "Ab1");
    expect(b1.a, "Ab1");
    expect((b1 as B).b, 1);

    var b2 = b.copyWithB(a: () => "Ab2", b: () => 2);
    expect(b2.a, "Ab2");
    expect(b2.b, 2);

    var c1 = c.copyWithA(a: () => "Ac1");
    expect(c1.a, "Ac1");
    expect((c1 as C).b, 1);
    expect((c1).c, true);

    var c2 = c.copyWithB(a: () => "Ac1", b: () => 3);
    expect(c2.a, "Ac1");
    expect(c2.b, 3);
    expect((c2 as C).c, true);

    var c3 = c.copyWithC(a: () => "Ac1", b: () => 3, c: () => false);
    expect(c3.a, "Ac1");
    expect(c3.b, 3);
    expect(c3.c, false);
  });
}
