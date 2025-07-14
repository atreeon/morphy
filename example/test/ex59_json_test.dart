import 'dart:convert';

import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex59_json_test.g.dart';
part 'ex59_json_test.morphy.dart';

//example of how whether different subclasses can be serialized and deserialized from the same list type

main() {
  test("1", () {
    var building = Building(
      people: [
        Person(age: 1),
        Athlete(age: 2, speed: 3),
        BaseballPlayer(age: 4, speed: 5, height: 6),
      ],
    );

    var json = building.toJson();
    var building2 = Building.fromJson(json);

    expect(building2, building);
  });
}

@Morphy(generateJson: true, explicitSubTypes: [$Athlete, $BaseballPlayer])
abstract class $Person {
  int get age;
}

@Morphy(generateJson: true, explicitSubTypes: [$BaseballPlayer])
abstract class $Athlete implements $Person {
  int get speed;
}

@Morphy(generateJson: true)
abstract class $BaseballPlayer implements $Athlete {
  int get height;
}

@Morphy(generateJson: true)
abstract class $Building {
  List<$Person> get people;
}
