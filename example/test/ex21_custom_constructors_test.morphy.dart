// ignore_for_file: UNNECESSARY_CAST

part of 'ex21_custom_constructors_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class A extends $A {
  final String a;

  ///
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
