import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex19_inheritance_generics.morphy.dart';

@morphy
abstract class $$A {}

@morphy
abstract class $$B implements $$A {}

@morphy
abstract class $$C<TBatchItem extends $$A> {
  List<TBatchItem> get items;
}

@morphy
abstract class $$D {
  List<$$B> get items;
}

@morphy
abstract class $E
    implements //
        $$C<$$B>,
        $$D {
  List<$$B> get items;
}
