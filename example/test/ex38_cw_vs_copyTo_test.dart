import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

// COPYWITH & COPYTO SUBLIST IS A VALUET2 TYPE

part 'ex38_cw_vs_copyTo_test.morphy.dart';

///copyToX converts the class to that new X class
///cwX, if actually a Y class, copies the new class but only specifies the X fields

@Morphy()
abstract class $$Super {
  String get x;
}

@Morphy(explicitSubTypes: [$SubB])
abstract class $SubA implements $$Super {}

@Morphy()
abstract class $SubB implements $$Super {
  String get z;
  List<$C> get cs;
}

@Morphy()
abstract class $C {
  String get m;
}

main() {
  test("subA to subB (sub sibling to sub)", () {
    //does copy with work
    var b = SubB(z: "z", cs: [C(m: "m")], x: "x");
    var b_copy1 = b.copyWith_SubB();
    expect(b_copy1.toString(), "(SubB-z:z|cs:[(C-m:m)]|x:x)");

    //copywith from SubB to SubB (traditional copy with)
    var b_copy2 = b.copyWith_SubB(cs: Opt([C(m: "m2")]));
    expect(b_copy2.toString(), "(SubB-z:z|cs:[(C-m:m2)]|x:x)");

    //copy TO from one sibling to another
    //cw copies the underlining type
    //copyTo creates a new type of the type that is specified
    //  here we take a SubA object and we create a new objet of type SubB
    SubA subA = SubA(x: "x");
    SubB subB = subA.changeTo_SubB(z: "z", cs: [C(m: "m")]);

    expect(subB.toString(), "(SubB-z:z|cs:[(C-m:m)]|x:x)");
  });
}
