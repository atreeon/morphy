// ignore_for_file: UNNECESSARY_CAST

part of 'ex37_changeTo_siblings_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

/// We can also copy to a sibling class.
/// todo: y property on SubA class not properly working. This doesn't quite work yet.
/// Any properties not in the newly created sibling class, the values are lost.
///
abstract class Super extends $$Super {
  String get x;
  Super copyWith_Super({
    Opt<String>? x,
  });
}

extension $$Super_changeTo_E on $$Super {}

enum Super$ { x }

///
///implements [$$Super]
///

/// We can also copy to a sibling class.
/// todo: y property on SubA class not properly working. This doesn't quite work yet.
/// Any properties not in the newly created sibling class, the values are lost.
///
class SubA extends $SubA implements Super {
  final String x;

  ///
  ///implements [$$Super]
  ///

  /// We can also copy to a sibling class.
  /// todo: y property on SubA class not properly working. This doesn't quite work yet.
  /// Any properties not in the newly created sibling class, the values are lost.
  ///
  SubA({
    required this.x,
  });
  String toString() => "(SubA-x:${x.toString()})";
  int get hashCode => hashObjects([x.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubA && runtimeType == other.runtimeType && x == other.x;
  SubA copyWith_Super({
    Opt<String>? x,
  }) {
    return SubA(
      x: x == null ? this.x as String : x.value as String,
    );
  }

  SubA copyWith_SubA({
    Opt<String>? x,
  }) {
    return SubA(
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

extension $SubA_changeTo_E on $SubA {
  SubB changeTo_SubB({
    required String z,
    Opt<String>? x,
  }) {
    return SubB(
      z: z as String,
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

enum SubA$ { x }

///
///implements [$$Super]
///

/// We can also copy to a sibling class.
/// todo: y property on SubA class not properly working. This doesn't quite work yet.
/// Any properties not in the newly created sibling class, the values are lost.
///
class SubB extends $SubB implements Super {
  final String z;
  final String x;

  ///
  ///implements [$$Super]
  ///

  /// We can also copy to a sibling class.
  /// todo: y property on SubA class not properly working. This doesn't quite work yet.
  /// Any properties not in the newly created sibling class, the values are lost.
  ///
  SubB({
    required this.z,
    required this.x,
  });
  String toString() => "(SubB-z:${z.toString()}|x:${x.toString()})";
  int get hashCode => hashObjects([z.hashCode, x.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubB &&
          runtimeType == other.runtimeType &&
          z == other.z &&
          x == other.x;
  SubB copyWith_Super({
    Opt<String>? x,
  }) {
    return SubB(
      x: x == null ? this.x as String : x.value as String,
      z: (this as SubB).z,
    );
  }

  SubB copyWith_SubB({
    Opt<String>? z,
    Opt<String>? x,
  }) {
    return SubB(
      z: z == null ? this.z as String : z.value as String,
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

extension $SubB_changeTo_E on $SubB {}

enum SubB$ { z, x }
