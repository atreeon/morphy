abstract class $$A {}

abstract class $$B implements $$A {}

abstract class $$C<TBatchItem extends $$A> {
  List<TBatchItem> get items;
}

abstract class $$D {
  List<$$B> get items;
}

abstract class $E
    implements //
        $$C<$$B>,
        $$D {
  List<$$B> get items;
}

//***generated

abstract class A extends $$A {}

abstract class B extends $$B implements A {}

abstract class C<TBatchItem extends $$A> extends $$C<TBatchItem> {
  List<TBatchItem> get items;
}

abstract class D extends $$D {
  List<B> get items;
}

class E extends $E implements C<$$B>, D {
  final List<B> items;
  E({
    required this.items,
  });
}
