// ignore_for_file: UNNECESSARY_CAST

part of 'ex38_cw_vs_copyTo_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///copyToX converts the class to that new X class
///cwX, if actually a Y class, copies the new class but only specifies the X fields
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

///copyToX converts the class to that new X class
///cwX, if actually a Y class, copies the new class but only specifies the X fields
///
class SubA extends $SubA implements Super {
  final String x;

  ///
  ///implements [$$Super]
  ///

  ///copyToX converts the class to that new X class
  ///cwX, if actually a Y class, copies the new class but only specifies the X fields
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
    required List<C> cs,
    Opt<String>? x,
  }) {
    return SubB(
      z: z as String,
      cs: cs as List<C>,
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

enum SubA$ { x }

///
///implements [$$Super]
///

///copyToX converts the class to that new X class
///cwX, if actually a Y class, copies the new class but only specifies the X fields
///
class SubB extends $SubB implements Super {
  final String z;
  final List<C> cs;
  final String x;

  ///
  ///implements [$$Super]
  ///

  ///copyToX converts the class to that new X class
  ///cwX, if actually a Y class, copies the new class but only specifies the X fields
  ///
  SubB({
    required this.z,
    required this.cs,
    required this.x,
  });
  String toString() =>
      "(SubB-z:${z.toString()}|cs:${cs.toString()}|x:${x.toString()})";
  int get hashCode => hashObjects([z.hashCode, cs.hashCode, x.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubB &&
          runtimeType == other.runtimeType &&
          z == other.z &&
          (cs).equalUnorderedD(other.cs) &&
          x == other.x;
  SubB copyWith_Super({
    Opt<String>? x,
  }) {
    return SubB(
      x: x == null ? this.x as String : x.value as String,
      z: (this as SubB).z,
      cs: (this as SubB).cs,
    );
  }

  SubB copyWith_SubB({
    Opt<String>? z,
    Opt<List<C>>? cs,
    Opt<String>? x,
  }) {
    return SubB(
      z: z == null ? this.z as String : z.value as String,
      cs: cs == null ? this.cs as List<C> : cs.value as List<C>,
      x: x == null ? this.x as String : x.value as String,
    );
  }
}

extension $SubB_changeTo_E on $SubB {}

enum SubB$ { z, cs, x }

///
class C extends $C {
  final String m;

  ///
  C({
    required this.m,
  });
  String toString() => "(C-m:${m.toString()})";
  int get hashCode => hashObjects([m.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C && runtimeType == other.runtimeType && m == other.m;
  C copyWith_C({
    Opt<String>? m,
  }) {
    return C(
      m: m == null ? this.m as String : m.value as String,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { m }
