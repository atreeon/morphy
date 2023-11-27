import 'package:morphy/morphy.dart';
import 'package:test/test.dart';

part 'ex1_simple_test.morphy.dart';

//THE SIMPLEST OF EXAMPLES

@morphy
abstract class $Pet {
  String get type;
}

main() {
  test("1", () {
    var a = Pet(type: "cat");

    expect(a.type, "cat");
  });
}
