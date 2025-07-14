import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

//SELF REFERENCING CLASS
part 'ex32_self_referencing_class_test.morphy.dart';

///where a property of one class is the same type

@morphy
abstract class $A {
  $A? get a;
  int get b;
  const $A();
}

main() {
  test("1", () {
    var a = A.constant(b: 1, a: A.constant(b: 2, a: null));

    expect(a.b, 1);
    expect(a.a!.b, 2);
  });
}
