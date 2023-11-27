// ignore_for_file: UNNECESSARY_CAST

part of 'ex33_list_equality_test.dart';

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
  String toString() => "(A-a:${a.toString()})";
  int get hashCode => hashObjects([a.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && a == other.a;
  A copyWith_A({
    Opt<String>? a,
  }) {
    return A(
      a: a == null ? this.a as String : a.value as String,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { a }

///
class B extends $B {
  final List<int> b;

  ///
  B({
    required this.b,
  });
  String toString() => "(B-b:${b.toString()})";
  int get hashCode => hashObjects([b.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          (b).equalUnorderedD(other.b);
  B copyWith_B({
    Opt<List<int>>? b,
  }) {
    return B(
      b: b == null ? this.b as List<int> : b.value as List<int>,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { b }

///
class C extends $C {
  final List<A> c;

  ///
  C({
    required this.c,
  });
  String toString() => "(C-c:${c.toString()})";
  int get hashCode => hashObjects([c.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          (c).equalUnorderedD(other.c);
  C copyWith_C({
    Opt<List<A>>? c,
  }) {
    return C(
      c: c == null ? this.c as List<A> : c.value as List<A>,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { c }
