// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex35_function_parameters_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///We can specify a morphy class as a function parameter
///but we must specify the dollar for the classname.
///
abstract class A extends $$A {
  int get id;
  bool Function($X) get t2TypeAsParameter1;
  bool Function(int, $X, int) get t2TypeAsParameter2;
  $X Function() get t2TypeAsReturn;
  X get stuff;
  A copyWith_A({
    Opt<int>? id,
    Opt<bool Function($X)>? t2TypeAsParameter1,
    Opt<bool Function(int, $X, int)>? t2TypeAsParameter2,
    Opt<$X Function()>? t2TypeAsReturn,
    Opt<X>? stuff,
  });
}

extension $$A_changeTo_E on $$A {}

enum A$ { id, t2TypeAsParameter1, t2TypeAsParameter2, t2TypeAsReturn, stuff }

///
///implements [$$A]
///

///We can specify a morphy class as a function parameter
///but we must specify the dollar for the classname.
///
class B extends $B implements A {
  final int id;
  final bool Function($X) t2TypeAsParameter1;
  final bool Function(int, $X, int) t2TypeAsParameter2;
  final $X Function() t2TypeAsReturn;
  final X stuff;

  ///
  ///implements [$$A]
  ///

  ///We can specify a morphy class as a function parameter
  ///but we must specify the dollar for the classname.
  ///
  B({
    required this.id,
    required this.t2TypeAsParameter1,
    required this.t2TypeAsParameter2,
    required this.t2TypeAsReturn,
    required this.stuff,
  });
  B._({
    required this.id,
    required this.t2TypeAsParameter1,
    required this.t2TypeAsParameter2,
    required this.t2TypeAsReturn,
    required this.stuff,
  });
  String toString() =>
      "(B-id:${id.toString()}|t2TypeAsParameter1:${t2TypeAsParameter1.toString()}|t2TypeAsParameter2:${t2TypeAsParameter2.toString()}|t2TypeAsReturn:${t2TypeAsReturn.toString()}|stuff:${stuff.toString()})";
  int get hashCode => hashObjects([
        id.hashCode,
        t2TypeAsParameter1.hashCode,
        t2TypeAsParameter2.hashCode,
        t2TypeAsReturn.hashCode,
        stuff.hashCode
      ]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          t2TypeAsParameter1 == other.t2TypeAsParameter1 &&
          t2TypeAsParameter2 == other.t2TypeAsParameter2 &&
          t2TypeAsReturn == other.t2TypeAsReturn &&
          stuff == other.stuff;
  B copyWith_A({
    Opt<int>? id,
    Opt<bool Function($X)>? t2TypeAsParameter1,
    Opt<bool Function(int, $X, int)>? t2TypeAsParameter2,
    Opt<$X Function()>? t2TypeAsReturn,
    Opt<X>? stuff,
  }) {
    return B._(
      id: id == null ? this.id as int : id.value as int,
      t2TypeAsParameter1: t2TypeAsParameter1 == null
          ? this.t2TypeAsParameter1 as bool Function($X)
          : t2TypeAsParameter1.value as bool Function($X),
      t2TypeAsParameter2: t2TypeAsParameter2 == null
          ? this.t2TypeAsParameter2 as bool Function(int, $X, int)
          : t2TypeAsParameter2.value as bool Function(int, $X, int),
      t2TypeAsReturn: t2TypeAsReturn == null
          ? this.t2TypeAsReturn as $X Function()
          : t2TypeAsReturn.value as $X Function(),
      stuff: stuff == null ? this.stuff as X : stuff.value as X,
    );
  }

  B copyWith_B({
    Opt<int>? id,
    Opt<bool Function($X)>? t2TypeAsParameter1,
    Opt<bool Function(int, $X, int)>? t2TypeAsParameter2,
    Opt<$X Function()>? t2TypeAsReturn,
    Opt<X>? stuff,
  }) {
    return B._(
      id: id == null ? this.id as int : id.value as int,
      t2TypeAsParameter1: t2TypeAsParameter1 == null
          ? this.t2TypeAsParameter1 as bool Function($X)
          : t2TypeAsParameter1.value as bool Function($X),
      t2TypeAsParameter2: t2TypeAsParameter2 == null
          ? this.t2TypeAsParameter2 as bool Function(int, $X, int)
          : t2TypeAsParameter2.value as bool Function(int, $X, int),
      t2TypeAsReturn: t2TypeAsReturn == null
          ? this.t2TypeAsReturn as $X Function()
          : t2TypeAsReturn.value as $X Function(),
      stuff: stuff == null ? this.stuff as X : stuff.value as X,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { id, t2TypeAsParameter1, t2TypeAsParameter2, t2TypeAsReturn, stuff }

///
class X extends $X {
  final int id;

  ///
  X({
    required this.id,
  });
  X._({
    required this.id,
  });
  String toString() => "(X-id:${id.toString()})";
  int get hashCode => hashObjects([id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is X && runtimeType == other.runtimeType && id == other.id;
  X copyWith_X({
    Opt<int>? id,
  }) {
    return X._(
      id: id == null ? this.id as int : id.value as int,
    );
  }
}

extension $X_changeTo_E on $X {}

enum X$ { id }
