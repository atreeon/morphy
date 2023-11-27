// ignore_for_file: UNNECESSARY_CAST

part of 'ex4_inheritance_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class Z extends $$Z {
  String get zValue;
  Z copyWith_Z({
    Opt<String>? zValue,
  });
}

extension $$Z_changeTo_E on $$Z {}

enum Z$ { zValue }

///
///implements [$$Z]
///

///
class A extends $A implements Z {
  final String aValue;
  final String zValue;

  ///
  ///implements [$$Z]
  ///

  ///
  A({
    required this.aValue,
    required this.zValue,
  });
  String toString() =>
      "(A-aValue:${aValue.toString()}|zValue:${zValue.toString()})";
  int get hashCode => hashObjects([aValue.hashCode, zValue.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A &&
          runtimeType == other.runtimeType &&
          aValue == other.aValue &&
          zValue == other.zValue;
  A copyWith_Z({
    Opt<String>? zValue,
  }) {
    return A(
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
      aValue: (this as A).aValue,
    );
  }

  A copyWith_A({
    Opt<String>? aValue,
    Opt<String>? zValue,
  }) {
    return A(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { aValue, zValue }

///
///implements [$A]
///

///
class B extends $B implements A {
  final String aValue;
  final String bValue;
  final String zValue;

  ///
  ///implements [$A]
  ///

  ///
  B({
    required this.aValue,
    required this.bValue,
    required this.zValue,
  });
  String toString() =>
      "(B-aValue:${aValue.toString()}|bValue:${bValue.toString()}|zValue:${zValue.toString()})";
  int get hashCode =>
      hashObjects([aValue.hashCode, bValue.hashCode, zValue.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          aValue == other.aValue &&
          bValue == other.bValue &&
          zValue == other.zValue;
  B copyWith_A({
    Opt<String>? aValue,
    Opt<String>? zValue,
  }) {
    return B(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
      bValue: (this as B).bValue,
    );
  }

  B copyWith_Z({
    Opt<String>? zValue,
  }) {
    return B(
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
      aValue: (this as B).aValue,
      bValue: (this as B).bValue,
    );
  }

  B copyWith_B({
    Opt<String>? aValue,
    Opt<String>? bValue,
    Opt<String>? zValue,
  }) {
    return B(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: bValue == null ? this.bValue as String : bValue.value as String,
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { aValue, bValue, zValue }

///
///implements [$B]
///

///
class C extends $C implements B {
  final String aValue;
  final String bValue;
  final String cValue;
  final String zValue;

  ///
  ///implements [$B]
  ///

  ///
  C({
    required this.aValue,
    required this.bValue,
    required this.cValue,
    required this.zValue,
  });
  String toString() =>
      "(C-aValue:${aValue.toString()}|bValue:${bValue.toString()}|cValue:${cValue.toString()}|zValue:${zValue.toString()})";
  int get hashCode => hashObjects(
      [aValue.hashCode, bValue.hashCode, cValue.hashCode, zValue.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          aValue == other.aValue &&
          bValue == other.bValue &&
          cValue == other.cValue &&
          zValue == other.zValue;
  C copyWith_B({
    Opt<String>? aValue,
    Opt<String>? bValue,
    Opt<String>? zValue,
  }) {
    return C(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: bValue == null ? this.bValue as String : bValue.value as String,
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
      cValue: (this as C).cValue,
    );
  }

  C copyWith_A({
    Opt<String>? aValue,
    Opt<String>? zValue,
  }) {
    return C(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
      bValue: (this as C).bValue,
      cValue: (this as C).cValue,
    );
  }

  C copyWith_Z({
    Opt<String>? zValue,
  }) {
    return C(
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
      aValue: (this as C).aValue,
      bValue: (this as C).bValue,
      cValue: (this as C).cValue,
    );
  }

  C copyWith_C({
    Opt<String>? aValue,
    Opt<String>? bValue,
    Opt<String>? cValue,
    Opt<String>? zValue,
  }) {
    return C(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: bValue == null ? this.bValue as String : bValue.value as String,
      cValue: cValue == null ? this.cValue as String : cValue.value as String,
      zValue: zValue == null ? this.zValue as String : zValue.value as String,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { aValue, bValue, cValue, zValue }
