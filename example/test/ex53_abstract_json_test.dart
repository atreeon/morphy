// ignore_for_file: unnecessary_cast

import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex53_abstract_json_test.g.dart';

part 'ex53_abstract_json_test.morphy.dart';

@Morphy(
  generateJson: true,
  explicitSubTypes: [$Todo2_complete, $Todo2_incomplete],
)
abstract class $Todo2 {
  String get title;

  String? get id;

  String get description;
}

@Morphy(generateJson: true)
abstract class $Todo2_incomplete implements $Todo2 {}

@Morphy(generateJson: true)
abstract class $Todo2_complete implements $Todo2 {
  DateTime get completedDate;
}

main() {
  test("1 toJson as A", () {
    var todoObjects = [
      Todo2_complete(
        title: "Todo2_complete",
        description: "description",
        completedDate: DateTime(2023, 11, 1),
      ),
      Todo2_incomplete(title: "Todo2_incomplete", description: "description"),
    ];

    var resultInJsonFormat = todoObjects
        .map((todo2) => todo2.toJson())
        .toList();

    var expectedJson = [
      {
        'title': 'Todo2_complete',
        'id': null,
        'description': 'description',
        'completedDate': '2023-11-01T00:00:00.000',
        '_className_': 'Todo2_complete',
      },
      {
        'title': 'Todo2_incomplete',
        'id': null,
        'description': 'description',
        '_className_': 'Todo2_incomplete',
      },
    ];

    expect(resultInJsonFormat, expectedJson);

    var resultXObjects = expectedJson
        .map((json) => Todo2.fromJson(json))
        .toList();

    expect(resultXObjects, todoObjects);
  });
}
