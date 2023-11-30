// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex34_list_equality_with_nulls_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class A extends $A {
  final String a;

  ///
  A({
    required this.a,
  });
  A._({
    required this.a,
  });
  String toString() => "(A-a:${a.toString()})";
  int get hashCode => hashObjects([a.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && a == other.a;
  A copyWith_A({
    Opt<String>? a,
  }) {
    return A._(
      a: a == null ? this.a as String : a.value as String,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { a }

///
class B extends $B {
  final List<int>? b;

  ///
  B({
    this.b,
  });
  B._({
    this.b,
  });
  String toString() => "(B-b:${b.toString()})";
  int get hashCode => hashObjects([b.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          (b ?? []).equalUnorderedD(other.b ?? []);
  B copyWith_B({
    Opt<List<int>?>? b,
  }) {
    return B._(
      b: b == null ? this.b as List<int>? : b.value as List<int>?,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { b }
