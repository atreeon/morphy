import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

// ignore_for_file: unnecessary_type_check

part 'ex44_a_copy_super_to_sub_generic_test.morphy.dart';

@Morphy(explicitSubTypes: [$Sub])
abstract class $Super {
  String get id;
}

@morphy
abstract class $Sub<T> implements $Super {
  String get description;
  T get code;
}

main() {
  test("1", () {
    var _super = Super(id: "id");
    var result = _super.changeToSub(description: "description", code: 5);
    expect(result is Sub, true);
  });
}
