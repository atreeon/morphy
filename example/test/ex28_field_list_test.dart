import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex28_field_list_test.morphy.dart';

///FIELD LIST ENUM
///It is sometimes useful to have an enum of all the individual fields specified for a class.
///
///This enum is created automatically and accessed using the classname followed by a dollar.
///
///It can be useful for specifying json field names for example rather than doing so manually

@morphy
abstract class $Pet {
  String? get type;
  String get name;
}

main() {
  test("1", () {
    expect(Pet$.type.toString(), 'Pet\$.type');
    expect(Pet$.type.toString(), 'Pet\$.type');
  });
}
