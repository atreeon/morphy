// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex11_generic_subclass_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class A<T1, T2> extends $$A<T1, T2> {
  T1 get x;
  T2 get y;
  A copyWith_A<T1, T2>({
    Opt<T1>? x,
    Opt<T2>? y,
  });
}

extension $$A_changeTo_E on $$A {}

enum A$ { x, y }

///
///implements [$$A]
///

///
class B extends $B implements A<int, String> {
  final int x;
  final String y;
  final String z;

  ///
  ///implements [$$A]
  ///

  ///
  B({
    required this.x,
    required this.y,
    required this.z,
  });
  B._({
    required this.x,
    required this.y,
    required this.z,
  });
  const B.constant({
    required this.x,
    required this.y,
    required this.z,
  });
  String toString() =>
      "(B-x:${x.toString()}|y:${y.toString()}|z:${z.toString()})";
  int get hashCode => hashObjects([x.hashCode, y.hashCode, z.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          z == other.z;
  B copyWith_A<T1, T2>({
    Opt<T1>? x,
    Opt<T2>? y,
  }) {
    return B._(
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
    return B._(
      x: x == null ? this.x as int : x.value as int,
      y: y == null ? this.y as String : y.value as String,
      z: z == null ? this.z as String : z.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { x, y, z }
