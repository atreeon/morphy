// ignore_for_file: UNNECESSARY_CAST

part of 'ex36_create_subclass_from_super_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

/// Use .copyToX to create a subclass from a superclass
/// todo: whats the difference between copyToX & cwX
///
class A extends $A {
  final String x;

  /// Use .copyToX to create a subclass from a superclass
  /// todo: whats the difference between copyToX & cwX
  ///
  A({
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
    return A(
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

extension $A_changeTo_E on $A {
  B changeTo_B({
    required String y,
    Opt<String>? x,
  }) {
    return B(
      y: y as String,
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

enum A$ { x }

///
///implements [$A]
///

/// Use .copyToX to create a subclass from a superclass
/// todo: whats the difference between copyToX & cwX
///
class B extends $B implements A {
  final String x;
  final String y;

  ///
  ///implements [$A]
  ///

  /// Use .copyToX to create a subclass from a superclass
  /// todo: whats the difference between copyToX & cwX
  ///
  B({
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
  B copyWith_A({
    Opt<String>? x,
  }) {
    return B(
      x: x == null ? this.x as String : x.value as String,
      y: (this as B).y,
    );
  }

  B copyWith_B({
    Opt<String>? x,
    Opt<String>? y,
  }) {
    return B(
      x: x == null ? this.x as String : x.value as String,
      y: y == null ? this.y as String : y.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { x, y }
