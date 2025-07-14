import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex34_list_equality_with_nulls_test.morphy.dart';

//EQUALITY WITH NULLABLE & NON NULLABLE LISTS

@morphy
abstract class $A {
  String get a;
}

@morphy
abstract class $B {
  List<int>? get b;
}

main() {
  test("1", () {
    var b1 = B(b: [1, 2, 3]);
    var b2 = B(b: [1, 2, 3, 4]);
    var b3 = B(b: [1, 3, 2]);
    var b4 = B(b: [1, 2, 3]);
    var b5 = B(b: null);
    var b6 = B(b: null);
    var b7 = B(b: []);
    var b8 = B(b: []);

    expect(b1 == b2, false);
    expect(b1 == b3, true);
    expect(b2 == b3, false);
    expect(b1 == b4, true);
    expect(b5 == b6, true);
    expect(b7 == b8, true);
    expect(b1 == b6, false);
    expect(b1 == b8, false);

    //todo: this should fail when it runs correctly!
    expect(b6 == b7, true); //true is the wrong result here
  });
}
