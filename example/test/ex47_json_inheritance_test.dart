// ignore_for_file: unnecessary_cast

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:morphy/morphy.dart';

part 'ex47_json_inheritance_test.g.dart';
part 'ex47_json_inheritance_test.morphy.dart';

@Morphy(generateJson: true, explicitSubTypes: [$B, $C])
abstract class $A {
  String get id;
}

@Morphy(generateJson: true)
abstract class $B implements $A {}

@Morphy(generateJson: true)
abstract class $C implements $A {
  List<int> get items;
}

main() {
  test("1 toJson", () {
    var a = A(id: "a");
    var b = B(id: "b");
    var c = C(id: "c", items: [1,  2, 3]);

    expect(a.toJson(), {'id': 'a', '_className_': 'A'});
    expect(b.toJson(), {'id': 'b', '_className_': 'B'});
    expect(c.toJson(), {
      'id': 'c',
      'items': [1, 2, 3],
      '_className_': 'C'
    });
  });

  test("2 fromJson", () {
    var aJson = A(id: "a").toJson();
    var bJson = B(id: "b").toJson();

    var a = A.fromJson(aJson);
    var aExpected = A(id: "a");
    expect(a, aExpected);

    //we use the A constructor to convert our B json object
    var b = A.fromJson(bJson);
    var bExpected = B(id: "b");
    expect(b, bExpected);

    //can also use the B constructor to convert only our B json object
    var b2 = B.fromJson(bJson);
    var b2Expected = B(id: "b");
    expect(b2, b2Expected);
  });
}
