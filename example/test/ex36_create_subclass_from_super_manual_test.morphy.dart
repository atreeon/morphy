// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex36_create_subclass_from_super_manual_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class A extends $A {
  final String x;

  ///
  A({
    required this.x,
  });
  A._({
    required this.x,
  });
  String toString() => "(A-x:${x.toString()})";
  int get hashCode => hashObjects([x.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && x == other.x;
  A copyWith_A({
    Opt<String>? x,
  }) {
    return A._(
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { x }

///
///implements [$A]
///

///
class B extends $B implements A {
  final String x;
  final String y;
  final C z;

  ///
  ///implements [$A]
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
  B copyWith_A({
    Opt<String>? x,
  }) {
    return B._(
      x: x == null ? this.x as String : x.value as String,
      y: (this as B).y,
      z: (this as B).z,
    );
  }

  B copyWith_B({
    Opt<String>? x,
    Opt<String>? y,
    Opt<C>? z,
  }) {
    return B._(
      x: x == null ? this.x as String : x.value as String,
      y: y == null ? this.y as String : y.value as String,
      z: z == null ? this.z as C : z.value as C,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { x, y, z }

///
class C extends $C {
  final String v;

  ///
  C({
    required this.v,
  });
  C._({
    required this.v,
  });
  String toString() => "(C-v:${v.toString()})";
  int get hashCode => hashObjects([v.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C && runtimeType == other.runtimeType && v == other.v;
  C copyWith_C({
    Opt<String>? v,
  }) {
    return C._(
      v: v == null ? this.v as String : v.value as String,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { v }
