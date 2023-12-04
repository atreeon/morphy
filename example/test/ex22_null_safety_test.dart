import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex22_null_safety_test.morphy.dart';

//NULL FIELD NAMES - NULL SAFETY USING ?

@morphy
abstract class $Pet {
  String? get type;
  String get name;
}

main() {
  test("1", () {
    var a = Pet(name: "mitzy");

    expect(a.name, "mitzy");
    expect(a.type, null);
  });
}
