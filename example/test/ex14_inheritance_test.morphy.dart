// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex14_inheritance_test.dart';

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
///implements [$A]
///

///
class B extends $B implements A {
  final String a;
  final int b;

  ///
  ///implements [$A]
  ///

  ///
  B({
    required this.a,
    required this.b,
  });
  B._({
    required this.a,
    required this.b,
  });
  String toString() => "(B-a:${a.toString()}|b:${b.toString()})";
  int get hashCode => hashObjects([a.hashCode, b.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b;
  B copyWith_A({
    Opt<String>? a,
  }) {
    return B._(
      a: a == null ? this.a as String : a.value as String,
      b: (this as B).b,
    );
  }

  B copyWith_B({
    Opt<String>? a,
    Opt<int>? b,
  }) {
    return B._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as int : b.value as int,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { a, b }

///
///implements [$B]
///

///
class C extends $C implements B {
  final String a;
  final int b;
  final bool c;

  ///
  ///implements [$B]
  ///

  ///
  C({
    required this.a,
    required this.b,
    required this.c,
  });
  C._({
    required this.a,
    required this.b,
    required this.c,
  });
  String toString() =>
      "(C-a:${a.toString()}|b:${b.toString()}|c:${c.toString()})";
  int get hashCode => hashObjects([a.hashCode, b.hashCode, c.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b &&
          c == other.c;
  C copyWith_B({
    Opt<String>? a,
    Opt<int>? b,
  }) {
    return C._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as int : b.value as int,
      c: (this as C).c,
    );
  }

  C copyWith_A({
    Opt<String>? a,
  }) {
    return C._(
      a: a == null ? this.a as String : a.value as String,
      b: (this as C).b,
      c: (this as C).c,
    );
  }

  C copyWith_C({
    Opt<String>? a,
    Opt<int>? b,
    Opt<bool>? c,
  }) {
    return C._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as int : b.value as int,
      c: c == null ? this.c as bool : c.value as bool,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { a, b, c }
