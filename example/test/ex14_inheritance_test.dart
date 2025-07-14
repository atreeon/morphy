import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex14_inheritance_test.morphy.dart';

//TOSTRING

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

    expect(a.toString(), "(A-a:A)");
    expect(b.toString(), "(B-a:A|b:1)");
    expect(c.toString(), "(C-a:A|b:1|c:true)");
  });
}
