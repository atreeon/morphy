import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex2_generic_interfaces_test.morphy.dart';

//GENERIC INTERFACES AND GENERICS ARE HANDLED AUTOMATICALLY

@morphy
abstract class $$A<T> {
  T get x;
}

@morphy
abstract class $B<T extends $C, T3> implements $$A<int>, $C {
  ///Blah
  T get y;
}

@morphy
abstract class $C {
  String get z;
}

main() {
  test("1", () {
    var b = B<C, int>(x: 5, y: C(z: "Z"), z: "null");

    expect(b.x, 5);
    expect(b.y.z, "Z");
    expect(b.z, "null");
  });
}
