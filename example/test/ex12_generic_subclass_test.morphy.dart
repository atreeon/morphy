// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex12_generic_subclass_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class A<Ta, Tb> extends $$A<Ta, Tb> {
  Ta get x;
  Tb get y;
  A copyWith_A<Ta, Tb>({
    Opt<Ta>? x,
    Opt<Tb>? y,
  });
}

extension $$A_changeTo_E on $$A {}

enum A$ { x, y }

///
///implements [$$A]
///

///
class B<Ta, Tb> extends $B<Ta, Tb> implements A<Ta, Tb> {
  final Ta x;
  final Tb y;
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
  B copyWith_A<Ta, Tb>({
    Opt<Ta>? x,
    Opt<Tb>? y,
  }) {
    return B._(
      x: x == null ? this.x as Ta : x.value as Ta,
      y: y == null ? this.y as Tb : y.value as Tb,
      z: (this as B).z,
    );
  }

  B copyWith_B<Ta, Tb>({
    Opt<Ta>? x,
    Opt<Tb>? y,
    Opt<String>? z,
  }) {
    return B._(
      x: x == null ? this.x as Ta : x.value as Ta,
      y: y == null ? this.y as Tb : y.value as Tb,
      z: z == null ? this.z as String : z.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { x, y, z }
