import 'package:morphy/morphy.dart';
import 'package:test/test.dart';

part 'ex54_default_constructor_json_test.g.dart';

part 'ex54_default_constructor_json_test.morphy.dart';

@Morphy(generateJson: true, explicitSubTypes: [$Todo2_complete, $Todo2_incomplete])
abstract class $$Todo2 {
  String get title;

  String get id;

  String get description;
}

@Morphy(generateJson: true, hidePublicConstructor: true)
abstract class $Todo2_incomplete implements $$Todo2 {}

@Morphy(generateJson: true)
abstract class $Todo2_complete implements $$Todo2 {
  DateTime get completedDate;
}

Todo2_incomplete todo2_incomplete_Factory({
  required String title,
  String? id,
  String description = '',
}) {
  assert(
    id == null || id.isNotEmpty,
    'id must either be null or not empty',
  );
  var _id = id ?? "xxx";

  return Todo2_incomplete._(
    id: _id,
    title: title,
    description: description,
  );
}

void main() {
  group("default constructor", () {
    test("0 ", () {
      var todo = todo2_incomplete_Factory(title: "title");

      var expected = Todo2_incomplete._(
        title: "title",
        id: "xxx",
        description: "",
      );
      expect(todo, expected);
    });
  });
}
