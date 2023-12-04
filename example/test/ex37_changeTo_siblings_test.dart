import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

// COPYTO FROM SUB CLASS TO A SIBLING SUB CLASS

part 'ex37_changeTo_siblings_test.morphy.dart';

/// We can also copy to a sibling class.
/// todo: y property on SubA class not properly working. This doesn't quite work yet.
/// Any properties not in the newly created sibling class, the values are lost.

@Morphy()
abstract class $$Super {
  String get x;
}

@Morphy(explicitSubTypes: [$SubB])
abstract class $SubA implements $$Super {
  // String get y; //todo: this currently doesn't work
}

@Morphy()
abstract class $SubB implements $$Super {
  // String get x;
  String get z;
}

main() {
  test("subA to subB (sub sibling to sub)", () {
    SubA subA = SubA(x: "x");
    SubB subB = subA.changeTo_SubB(z: "z");

    expect(subB.toString(), "(SubB-z:z|x:x)");
  });
}
