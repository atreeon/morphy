import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex63_property_shadow_global_type.morphy.dart';
part 'ex63_property_shadow_global_type.g.dart';

//nullable private getters and private morphy class

main() {
  test("1", () {
    final test = Test(
      String: 1,
      Object: 2,
      List: 3,
      Map: 4,
      Never: (5, 6),
      Type: (7, named: 8),
      bool: [2, 'abc'],
      hashObjects: [4, 5],
      identical: [6, 7],
    );
    expect(test.String, 1);
    expect(test.bool, [2, 'abc']);
    expect(Test.fromJson(test.toJson()).toJson(), test.toJson());

    final test2 = Test2(PositionalFunction: (a, [b = 3, c = 5]) => a + b + c);
    final f = test2.PositionalFunction;
    expect(f(5, 5), 15);
  });
}

typedef Int = int;
typedef _List<E> = List<E>;
typedef IntList = List<int>;

@Morphy(generateJson: true)
abstract class $Test {
  Int get String;
  Int get Object;
  Int get List;
  Int get Map;
  (Int, Int)? get Never;
  (Int, {Int named}) get Type;
  _List<(Int, Int)>? get int;
  _List get bool;
  IntList get hashObjects;
  _List<Int> get identical;
}

@Morphy(generateJson: false)
abstract class $Test2 {
  Int Function(Int p1, {Int n1, required Int n2})? get Function;
  Int Function(Int p1, [Int p2, Int p3]) get PositionalFunction;
}
