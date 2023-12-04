import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex41_inheritance_generics.morphy.dart';

enum eEnumExample { unknown, non200ResponseCode }

@Morphy()
abstract class $$A<T> {}

//sibling of C, subclass of A, with a generic property of type A
@Morphy()
abstract class $B<T> implements $$A<T> {
  T get data;
}

//sibling of B, subclass of A
@Morphy()
abstract class $C<T> implements $$A<T> {
  eEnumExample get failureCode;

  String get description;
}
