// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex19_inheritance_generics.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class A extends $$A {
  A copyWith_A();
}

extension $$A_changeTo_E on $$A {}

///
///implements [$$A]
///

///
abstract class B extends $$B implements A {
  B copyWith_A();
  B copyWith_B();
}

extension $$B_changeTo_E on $$B {}

///
abstract class C<TBatchItem extends $$A> extends $$C<TBatchItem> {
  List<TBatchItem> get items;
  C copyWith_C<TBatchItem extends $$A>({
    Opt<List<TBatchItem>>? items,
  });
}

extension $$C_changeTo_E on $$C {}

enum C$ { items }

///
abstract class D extends $$D {
  List<B> get items;
  D copyWith_D({
    Opt<List<B>>? items,
  });
}

extension $$D_changeTo_E on $$D {}

enum D$ { items }

///
///implements [$$C]
///

///
///implements [$$D]
///

///
class E extends $E implements C<$$B>, D {
  final List<B> items;

  ///
  ///implements [$$C]
  ///

  ///
  ///implements [$$D]
  ///

  ///
  E({
    required this.items,
  });
  E._({
    required this.items,
  });
  String toString() => "(E-items:${items.toString()})";
  int get hashCode => hashObjects([items.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is E &&
          runtimeType == other.runtimeType &&
          (items).equalUnorderedD(other.items);
  E copyWith_C<TBatchItem extends $$A>({
    Opt<List<TBatchItem>>? items,
  }) {
    return E._(
      items: items == null ? this.items as List<B> : items.value as List<B>,
    );
  }

  E copyWith_D({
    Opt<List<B>>? items,
  }) {
    return E._(
      items: items == null ? this.items as List<B> : items.value as List<B>,
    );
  }

  E copyWith_E({
    Opt<List<B>>? items,
  }) {
    return E._(
      items: items == null ? this.items as List<B> : items.value as List<B>,
    );
  }
}

extension $E_changeTo_E on $E {}

enum E$ { items }
