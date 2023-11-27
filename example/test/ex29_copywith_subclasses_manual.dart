import 'package:morphy/morphy.dart';
import 'package:test/test.dart';

// ignore_for_file: UNNECESSARY_CAST

abstract class A {
  String get a;

  A copyWith_A({
    Opt<String>? a,
  });
}

class B<T1> implements A {
  final String a;
  final T1 b;

  B({required this.a, required this.b});

  String toString() => "${a.toString()} ${b.toString()}";

  B copyWith_A({
    Opt<String>? a,
  }) {
    return B(
      a: a == null ? this.a as String : a.value as String,
      b: (this as B).b,
    );
  }

  B copyWith_B({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return B(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
    );
  }
}

class C<T1> implements B<T1> {
  final String a;
  final T1 b;
  final bool c;

  C({required this.a, required this.b, required this.c});

  String toString() => "${a.toString()} ${b.toString()} ${c.toString()}";

  C copyWith_A({
    Opt<String>? a,
  }) {
    return C(
      a: a == null ? this.a as String : a.value as String,
      b: (this as C).b,
      c: (this as C).c,
    );
  }

  C copyWith_B({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return C(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
      c: (this as C).c,
    );
  }

  C copyWith_C({
    Opt<String>? a,
    Opt<T1>? b,
    Opt<bool>? c,
  }) {
    return C(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
      c: c == null ? this.c as bool : c.value as bool,
    );
  }
}

class D<T1> implements B<T1> {
  final String a;
  final T1 b;

  D({required this.a, required this.b});

  String toString() => "${a.toString()} ${b.toString()}";

  D copyWith_A({
    Opt<String>? a,
  }) {
    return D(
      a: a == null ? this.a as String : a.value as String,
      b: (this as D).b,
    );
  }

  D copyWith_B({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return D(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
    );
  }

  D copyWith_D({
    Opt<String>? a,
    Opt<T1>? b,
  }) {
    return D(
      a: a == null ? this.a as String : a.value as String,
      b: b == null ? this.b as T1 : b.value as T1,
    );
  }
}

abstract class X {
  X copyWith_X();
}

class Y implements X {
  final String a;

  Y({required this.a});

  String toString() => "${a.toString()}";

  Y copyWith_X() {
    return Y(
      a: (this as Y).a,
    );
  }

  Y copyWith_Y({
    Opt<String>? a,
  }) {
    return Y(
      a: a == null ? this.a as String : a.value as String,
    );
  }
}

main() {
  test("ba", () {
    A ba = B(b: 5, a: "A");
    A ba_copy = ba.copyWith_A(a: Opt("a"));
    expect(ba_copy.toString(), "a 5");
  });

  test("bb", () {
    B bb = B(b: 5, a: "A");
    B bb_copy = bb.copyWith_B(a: Opt("a"), b: Opt(6));
    expect(bb_copy.toString(), "a 6");
  });

  test("ca", () {
    A ca = C(b: 5, a: "A", c: true);
    A ca_copy = ca.copyWith_A(a: Opt("a"));
    expect(ca_copy.toString(), "a 5 true");
  });

  test("cb", () {
    B cb = C(b: 5, a: "A", c: true);
    B cb_copy = cb.copyWith_B(a: Opt("a"), b: Opt(6));
    expect(cb_copy.toString(), "a 6 true");
  });

  test("cc", () {
    C cc = C(b: 5, a: "A", c: true);
    var cc_copy = cc.copyWith_C(a: Opt("a"), b: Opt(6), c: Opt(false));
    expect(cc_copy.toString(), "a 6 false");
  });

  test("da", () {
    D da = D(b: 5, a: "A");
    var da_copy = da.copyWith_A(a: Opt("a"));
    expect(da_copy.toString(), "a 5");
  });

  test("db", () {
    D db = D(b: 5, a: "A");
    var db_copy = db.copyWith_B(a: Opt("a"), b: Opt(6));
    expect(db_copy.toString(), "a 6");
  });

  test("dd", () {
    D dd = D(b: 5, a: "A");
    var dd_copy = dd.copyWith_D(a: Opt("a"), b: Opt(6));
    expect(dd_copy.toString(), "a 6");
  });

  test("yx", () {
    Y yx = Y(a: "A");
    var yx_copy = yx.copyWith_X();
    expect(yx_copy.toString(), "A");
  });

  test("yY", () {
    Y yy = Y(a: "A");
    var yy_copy = yy.copyWith_Y(a: Opt("a"));
    expect(yy_copy.toString(), "a");
  });
}
