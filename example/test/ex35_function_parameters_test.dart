import 'package:test/test.dart';
import 'package:morphy/morphy.dart';

part 'ex35_function_parameters_test.morphy.dart';

//PARAMETERS OF A TYPE FUNCTION, THAT INCLUDE A VALUET2 OBJECT, MUST RETAIN THE DOLLAR
//RETURN VALUES SHOULD REMOVE THE DOLLAR

///We can specify a morphy class as a function parameter
///but we must specify the dollar for the classname.

@morphy
abstract class $$A {
  int get id;

  bool Function($X) get t2TypeAsParameter1;

  bool Function(int, $X, int) get t2TypeAsParameter2;

  $X Function() get t2TypeAsReturn;

  $X get stuff;
}

@morphy
abstract class $B implements $$A {}

@morphy
abstract class $X {
  int get id;
}

main() {
  test("asdf", () {
    var blah = B(
      id: 1,
      t2TypeAsParameter1: (x) => true,
      t2TypeAsParameter2: (i1, x, i2) => true,
      t2TypeAsReturn: () => X(id: 5),
      stuff: X(id: 5),
    );

    expect(blah.id, 1);
  });
}
