// ignore_for_file: unnecessary_cast

import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex51_json_inheritance_generic_from_test.g.dart';
part 'ex51_json_inheritance_generic_from_test.morphy.dart';

main() {
  test("1 fromJson as A", () {
    var jsonList = [
      {'id': '1', '_className_': 'A'},
      {'id': '2', 'blah': 'sdf', '_className_': 'B', '_T_': 'String'},
      {
        'id': '2',
        'blah': {'xyz': 'my custom', '_className_': 'X'},
        '_className_': 'B',
        '_T_': 'X'
      }
    ];

    B_Generics_Sing().fns = {
      ["String"]: (Map<String, dynamic> json) => _$BFromJson<String>(json, (x) => x as String),
      ["X"]: (Map<String, dynamic> json) => _$BFromJson<X>(json, (x) => X.fromJson(x as Map<String, dynamic>)),
    };

    var result = jsonList.map((e) => A.fromJson(e)).toList();

    var expected = [
      A(id: "1"),
      B(id: "2", blah: "sdf"),
      B(id: "2", blah: X(xyz: "my custom")),
    ];

    expect(result, expected);
    expect(expected[0].runtimeType, A);
    expect(expected[1].runtimeType, B<String>);
    expect(expected[2].runtimeType, B<X>);
  });

  test("2 fromJson as B", () {
    var jsonList = [
      {'id': '2', 'blah': 'sdf', '_className_': 'B', '_T_': 'String'},
      {
        'id': '2',
        'blah': {'xyz': 'my custom', '_className_': 'X'},
        '_className_': 'B',
        '_T_': 'X'
      }
    ];

    B_Generics_Sing().fns[["String"]] = (Map<String, dynamic> json) => _$BFromJson<String>(json, (x) => x as String);
    B_Generics_Sing().fns[["X"]] = (Map<String, dynamic> json) => _$BFromJson<X>(json, (x) => X.fromJson(x as Map<String, dynamic>));

    var result = jsonList.map((e) => A.fromJson(e)).toList();

    var expected = [
      B(id: "2", blah: "sdf"),
      B(id: "2", blah: X(xyz: "my custom")),
    ];

    expect(result, expected);
    expect(expected[0].runtimeType, B<String>);
    expect(expected[1].runtimeType, B<X>);
  });
}

@Morphy(generateJson: true, explicitSubTypes: [$B])
abstract class $A {
  String get id;
}

@Morphy(generateJson: true)
abstract class $B<T> implements $A {
  T get blah;
}

@Morphy(generateJson: true)
abstract class $X {
  String get xyz;
}
