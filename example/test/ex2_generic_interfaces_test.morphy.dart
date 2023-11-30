// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex2_generic_interfaces_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class A<T> extends $$A<T> {
  T get x;
  A copyWith_A<T>({
    Opt<T>? x,
  });
}

extension $$A_changeTo_E on $$A {}

enum A$ { x }

///
///implements [$$A]
///

///
///implements [$C]
///

///
class B<T extends $C, T3> extends $B<T, T3> implements A<int>, C {
  final int x;

  ///Blah
  final T y;
  final String z;

  ///
  ///implements [$$A]
  ///

  ///
  ///implements [$C]
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
  B copyWith_A<T>({
    Opt<T>? x,
  }) {
    return B._(
      x: x == null ? this.x as int : x.value as int,
      y: (this as B).y,
      z: (this as B).z,
    );
  }

  B copyWith_C({
    Opt<String>? z,
  }) {
    return B._(
      z: z == null ? this.z as String : z.value as String,
      x: (this as B).x,
      y: (this as B).y,
    );
  }

  B copyWith_B<T extends $C, T3>({
    Opt<int>? x,
    Opt<T>? y,
    Opt<String>? z,
  }) {
    return B._(
      x: x == null ? this.x as int : x.value as int,
      y: y == null ? this.y as T : y.value as T,
      z: z == null ? this.z as String : z.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { x, y, z }

///
class C extends $C {
  final String z;

  ///
  C({
    required this.z,
  });
  C._({
    required this.z,
  });
  String toString() => "(C-z:${z.toString()})";
  int get hashCode => hashObjects([z.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C && runtimeType == other.runtimeType && z == other.z;
  C copyWith_C({
    Opt<String>? z,
  }) {
    return C._(
      z: z == null ? this.z as String : z.value as String,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { z }
