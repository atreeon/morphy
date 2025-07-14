import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex60_copywith_generic_test.morphy.dart';

//this shows a bug where the copywith doesn't quite work properly

main() {
  test("1", () {
    var a = A<int>(x: 1, y: 2);

    var aAsInt = a.copyWithA(x: () => 2);

    expect(aAsInt.runtimeType, A<int>);
  });
}

@morphy
abstract class $A<T> {
  T get x;
  T get y;
}
