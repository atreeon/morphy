// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex29_copywith_subclasses_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///Copywith from subclass to superclass & superclass to subclass
///
abstract class A extends $$A {
  String get a;
  A copyWith_A({
    Opt<String>? a,
  });
}

extension $$A_changeTo_E on $$A {}

enum A$ { a }

///
///implements [$$A]
///

///Copywith from subclass to superclass & superclass to subclass
///
class B<T1> extends $B<T1> implements A {
  final String a;
  final T1 b;

  ///
  ///implements [$$A]
  ///

  ///Copywith from subclass to superclass & superclass to subclass
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

  B copyWith_B<T1>({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return B._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { a, b }

///
///implements [$B]
///

///
class C<T1> extends $C<T1> implements B<T1> {
  final String a;
  final T1 b;
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
  C copyWith_B<T1>({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return C._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
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

  C copyWith_C<T1>({
    Opt<String>? a,
    Opt<T1>? b,
    Opt<bool>? c,
  }) {
    return C._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
      c: c == null ? this.c as bool : c.value as bool,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { a, b, c }

///
///implements [$B]
///

///
class D<T1> extends $D<T1> implements B<T1> {
  final String a;
  final T1 b;

  ///
  ///implements [$B]
  ///

  ///
  D({
    required this.a,
    required this.b,
  });
  D._({
    required this.a,
    required this.b,
  });
  String toString() => "(D-a:${a.toString()}|b:${b.toString()})";
  int get hashCode => hashObjects([a.hashCode, b.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is D &&
          runtimeType == other.runtimeType &&
          a == other.a &&
          b == other.b;
  D copyWith_B<T1>({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return D._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
    );
  }

  D copyWith_A({
    Opt<String>? a,
  }) {
    return D._(
      a: a == null ? this.a as String : a.value as String,
      b: (this as D).b,
    );
  }

  D copyWith_D<T1>({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return D._(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
    );
  }
}

extension $D_changeTo_E on $D {}

enum D$ { a, b }

///
abstract class X extends $$X {
  X copyWith_X();
}

extension $$X_changeTo_E on $$X {}

///
///implements [$$X]
///

///
class Y extends $Y implements X {
  final String a;

  ///
  ///implements [$$X]
  ///

  ///
  Y({
    required this.a,
  });
  Y._({
    required this.a,
  });
  String toString() => "(Y-a:${a.toString()})";
  int get hashCode => hashObjects([a.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Y && runtimeType == other.runtimeType && a == other.a;
  Y copyWith_X() {
    return Y._(
      a: (this as Y).a,
    );
  }

  Y copyWith_Y({
    Opt<String>? a,
  }) {
    return Y._(
      a: a == null ? this.a as String : a.value as String,
    );
  }
}

extension $Y_changeTo_E on $Y {}

enum Y$ { a }
