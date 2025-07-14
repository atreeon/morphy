import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex31_constant_constructor_test.morphy.dart';

///To create a constant constructor, create the definition in our class definition.
///That then creates an alternative constructor that is a constant named .constant

@morphy
abstract class $A {
  int get a;
  const $A();
}

class MyStaticClass {
  static const concepts2 = <A>[A.constant(a: 5)];
}

main() {
  test("1", () {
    var a = A.constant(a: 1);

    expect(a.a, 1);

    //you can't change a constant object but you can copy and then change one
    var copya = a.copyWithA();

    expect(copya.a, 1);
  });
}
