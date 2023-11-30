// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex31_constant_constructor_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///To create a constant constructor, create the definition in our class definition.
///That then creates an alternative constructor that is a constant named .constant
///
class A extends $A {
  final int a;

  ///To create a constant constructor, create the definition in our class definition.
  ///That then creates an alternative constructor that is a constant named .constant
  ///
  A({
    required this.a,
  });
  A._({
    required this.a,
  });
  const A.constant({
    required this.a,
  });
  String toString() => "(A-a:${a.toString()})";
  int get hashCode => hashObjects([a.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && a == other.a;
  A copyWith_A({
    Opt<int>? a,
  }) {
    return A._(
      a: a == null ? this.a as int : a.value as int,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { a }
