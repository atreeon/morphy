import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

// ignore_for_file: UNNECESSARY_CAST

abstract class A<T1, T2> {
  T1 get x;
  T2 get y;

  A copyWith_A<T1, T2>({
    Opt<T1>? x,
    Opt<T2>? y,
  });
}

class B implements A<int, String> {
  final int x;
  final String y;
  final String z;

  B({
    required this.x,
    required this.y,
    required this.z,
  });

  String toString() => "(B-x:$x|y:$y|z:$z)";

  B copyWith_A<T1, T2>({
    Opt<T1>? x,
    Opt<T2>? y,
  }) {
    return B(
      x: x == null ? this.x as int : x.value as int,
      y: y == null ? this.y as String : y.value as String,
      z: (this as B).z,
    );
  }

  B copyWith_B({
    Opt<int>? x,
    Opt<String>? y,
    Opt<String>? z,
  }) {
    return B(
      x: x == null ? this.x as int : x.value as int,
      y: y == null ? this.y as String : y.value as String,
      z: z == null ? this.z as String : z.value as String,
    );
  }
}

main() {
  test("1 ba copy with", () {
    var b = B(x: 1, y: "y", z: "z");
    var ba_copy = b.copyWith_A(x: Opt(2), y: Opt("Y"));
    expect(ba_copy.toString(), "(B-x:2|y:Y|z:z)");
  });

  test("2 bb copy with", () {
    var b = B(x: 1, y: "y", z: "z");
    var bb_copy = b.copyWith_B(x: Opt(2), y: Opt("Y"), z: Opt("Z"));
    expect(bb_copy.toString(), "(B-x:2|y:Y|z:Z)");
  });
}
