// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex39_copyTo_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class Super extends $$Super {
  String get x;
  Super copyWith_Super({
    Opt<String>? x,
  });
}

extension $$Super_changeTo_E on $$Super {
  B changeTo_B({
    required String y,
    Opt<String>? x,
  }) {
    return B._(
      y: y as String,
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

enum Super$ { x }

///
///implements [$$Super]
///

///
class A extends $A implements Super {
  final String x;
  final String z;

  ///
  ///implements [$$Super]
  ///

  ///
  A({
    required this.x,
    required this.z,
  });
  A._({
    required this.x,
    required this.z,
  });
  String toString() => "(A-x:${x.toString()}|z:${z.toString()})";
  int get hashCode => hashObjects([x.hashCode, z.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          z == other.z;
  A copyWith_Super({
    Opt<String>? x,
  }) {
    return A._(
      x: x == null ? this.x as String : x.value as String,
      z: (this as A).z,
    );
  }

  A copyWith_A({
    Opt<String>? x,
    Opt<String>? z,
  }) {
    return A._(
      x: x == null ? this.x as String : x.value as String,
      z: z == null ? this.z as String : z.value as String,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { x, z }

///
///implements [$$Super]
///

///
class B extends $B implements Super {
  final String x;
  final String y;

  ///
  ///implements [$$Super]
  ///

  ///
  B({
    required this.x,
    required this.y,
  });
  B._({
    required this.x,
    required this.y,
  });
  String toString() => "(B-x:${x.toString()}|y:${y.toString()})";
  int get hashCode => hashObjects([x.hashCode, y.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;
  B copyWith_Super({
    Opt<String>? x,
  }) {
    return B._(
      x: x == null ? this.x as String : x.value as String,
      y: (this as B).y,
    );
  }

  B copyWith_B({
    Opt<String>? x,
    Opt<String>? y,
  }) {
    return B._(
      x: x == null ? this.x as String : x.value as String,
      y: y == null ? this.y as String : y.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { x, y }
