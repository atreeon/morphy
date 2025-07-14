import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex18_inheritance_generics.morphy.dart';

// Trigger regeneration to test casting fix

//superclass
@morphy
abstract class $A<T> {
  List<T> get batchItems;
}

//subclass of generic unrelated class X
@morphy
abstract class $B implements $A<$X> {
  List<$X> get batchItems;
}

//unrelated class
@morphy
abstract class $X {
  int get id;
}
