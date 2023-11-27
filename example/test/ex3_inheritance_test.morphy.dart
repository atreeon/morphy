// ignore_for_file: UNNECESSARY_CAST

part of 'ex3_inheritance_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class A extends $A {
  final String aValue;

  ///
  A({
    required this.aValue,
  });
  String toString() => "(A-aValue:${aValue.toString()})";
  int get hashCode => hashObjects([aValue.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && aValue == other.aValue;
  A copyWith_A({
    Opt<String>? aValue,
  }) {
    return A(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { aValue }

///
///implements [$A]
///

///
class B extends $B implements A {
  final String aValue;
  final String bValue;

  ///
  ///implements [$A]
  ///

  ///
  B({
    required this.aValue,
    required this.bValue,
  });
  String toString() =>
      "(B-aValue:${aValue.toString()}|bValue:${bValue.toString()})";
  int get hashCode => hashObjects([aValue.hashCode, bValue.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          aValue == other.aValue &&
          bValue == other.bValue;
  B copyWith_A({
    Opt<String>? aValue,
  }) {
    return B(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: (this as B).bValue,
    );
  }

  B copyWith_B({
    Opt<String>? aValue,
    Opt<String>? bValue,
  }) {
    return B(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: bValue == null ? this.bValue as String : bValue.value as String,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { aValue, bValue }

///
///implements [$B]
///

///
class C extends $C implements B {
  final String aValue;
  final String bValue;
  final String cValue;

  ///
  ///implements [$B]
  ///

  ///
  C({
    required this.aValue,
    required this.bValue,
    required this.cValue,
  });
  String toString() =>
      "(C-aValue:${aValue.toString()}|bValue:${bValue.toString()}|cValue:${cValue.toString()})";
  int get hashCode =>
      hashObjects([aValue.hashCode, bValue.hashCode, cValue.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          aValue == other.aValue &&
          bValue == other.bValue &&
          cValue == other.cValue;
  C copyWith_B({
    Opt<String>? aValue,
    Opt<String>? bValue,
  }) {
    return C(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: bValue == null ? this.bValue as String : bValue.value as String,
      cValue: (this as C).cValue,
    );
  }

  C copyWith_A({
    Opt<String>? aValue,
  }) {
    return C(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: (this as C).bValue,
      cValue: (this as C).cValue,
    );
  }

  C copyWith_C({
    Opt<String>? aValue,
    Opt<String>? bValue,
    Opt<String>? cValue,
  }) {
    return C(
      aValue: aValue == null ? this.aValue as String : aValue.value as String,
      bValue: bValue == null ? this.bValue as String : bValue.value as String,
      cValue: cValue == null ? this.cValue as String : cValue.value as String,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { aValue, bValue, cValue }
