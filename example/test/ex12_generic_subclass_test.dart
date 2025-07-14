import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex12_generic_subclass_test.morphy.dart';

//GENERIC SPECIFIED OF IMPLEMENTED CLASS, WITH ANOTHER GENERIC

@morphy
abstract class $$A<Ta, Tb> {
  Ta get x;
  Tb get y;
}

@morphy
abstract class $B<Ta, Tb> implements $$A<Ta, Tb> {
  String get z;
}

main() {
  test("1", () {
    var b = B(x: 1, y: 2, z: "a string");

    expect(b.x, 1);
    expect(b.y, 2);
    expect(b.z, "a string");
  });

  test("2 copyWithB should use proper generic types", () {
    var b = B<int, String>(x: 1, y: "hello", z: "test");
    var b2 = b.copyWithB(x: 2, y: "world");

    expect(b2.x, 2);
    expect(b2.y, "world");
    expect(b2.z, "test");
  });

  test("3 debug method signature", () {
    var b = B<int, String>(x: 1, y: "hello", z: "test");
    // This test will show us what types are actually being used
    // The copyWithB method should accept Ta and Tb (int and String)
    // but it's currently accepting dynamic

    // Test that it accepts the correct types
    var b2 = b.copyWithB(x: 42, y: "new value", z: "updated");
    expect(b2.x, 42);
    expect(b2.y, "new value");
    expect(b2.z, "updated");

    // Print the runtime types to debug
    print("b.x.runtimeType: ${b.x.runtimeType}");
    print("b.y.runtimeType: ${b.y.runtimeType}");
    print("b.z.runtimeType: ${b.z.runtimeType}");
  });
}
