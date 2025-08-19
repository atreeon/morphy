import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex63_class_with_no_members_test.morphy.dart';

@Morphy(explicitSubTypes: [$AgreedEulaState])
abstract class $EulaState {
  // lack of members
}

@Morphy()
abstract class $AgreedEulaState implements $EulaState {
  bool get test;
}

main() {
  test("1", () {
    var b = AgreedEulaState(test: true);

    expect(b.test, true);
  });
}
