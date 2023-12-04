

import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex24_generics_fields_test.morphy.dart';

///A LIST THAT IS OF A GENERATED GENERIC TYPE

//our class
@morphy
abstract class $A {
  List<$X> get xItems;
}

//unrelated class
@morphy
abstract class $X {
  String get value;
}

main() {
  test("1", () {
    var a = A(
      xItems: [X(value: "value")],
    );

    var result = a.xItems.map((e) => getItemValue(e)).toList();

    expect(result[0], "value");
  });
}

String getItemValue(X item) {
  return item.value;
}
