import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

// COPY WITH FROM SUPER CLASS TO SUB CLASS

part 'ex36_create_subclass_from_super_manual_test.morphy.dart';

@morphy
abstract class $A {
  String get x;
}

@morphy
abstract class $B implements $A {
  String get x;
  String get y;
  $C get z;
}

@morphy
abstract class $C {
  String get v;
}

extension A_E on A {
  B copyToB({
    Opt<String>? x,
    required String y,
    required $C z,
  }) {
    return B(
      x: x == null ? this.x : x.value as String,
      y: y,
      z: z as C,
    );
  }
}

main() {
  test("a to b (super to sub)", () {
    A a = A(x: "x");
    B b = a.copyToB(y: "y", z: C(v: "v"));

    expect(b.toString(), "(B-x:x|y:y|z:(C-v:v))");
  });
}
