// ignore_for_file: UNNECESSARY_CAST

part of 'ex41_inheritance_generics.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class A<T> extends $$A<T> {
  A copyWith_A<T>();
}

extension $$A_changeTo_E on $$A {}

///
///implements [$$A]
///

///
class B<T> extends $B<T> implements A<T> {
  final T data;

  ///
  ///implements [$$A]
  ///

  ///
  B({
    required this.data,
  });
  String toString() => "(B-data:${data.toString()})";
  int get hashCode => hashObjects([data.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B && runtimeType == other.runtimeType && data == other.data;
  B copyWith_A<T>() {
    return B(
      data: (this as B).data,
    );
  }

  B copyWith_B<T>({
    Opt<T>? data,
  }) {
    return B(
      data: data == null ? this.data as T : data.value as T,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { data }

///
///implements [$$A]
///

///
class C<T> extends $C<T> implements A<T> {
  final eEnumExample failureCode;
  final String description;

  ///
  ///implements [$$A]
  ///

  ///
  C({
    required this.failureCode,
    required this.description,
  });
  String toString() =>
      "(C-failureCode:${failureCode.toString()}|description:${description.toString()})";
  int get hashCode => hashObjects([failureCode.hashCode, description.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          failureCode == other.failureCode &&
          description == other.description;
  C copyWith_A<T>() {
    return C(
      failureCode: (this as C).failureCode,
      description: (this as C).description,
    );
  }

  C copyWith_C<T>({
    Opt<eEnumExample>? failureCode,
    Opt<String>? description,
  }) {
    return C(
      failureCode: failureCode == null
          ? this.failureCode as eEnumExample
          : failureCode.value as eEnumExample,
      description: description == null
          ? this.description as String
          : description.value as String,
    );
  }
}

extension $C_changeTo_E on $C {}

enum C$ { failureCode, description }
