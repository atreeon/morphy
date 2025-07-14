// ignore_for_file: unnecessary_cast

import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex52_json_inheritance_generic_test.g.dart';

part 'ex52_json_inheritance_generic_test.morphy.dart';

main() {
  test("1 toJson as A", () {
    var toJsonAs = [
      A<String>(id: "x"),
      A<int>(id: 1),
      B<String, int>(id: "2", valT1: "myString", valT2: 5),
      C<String, String>(id: "id", valT1: "valT1", valT2: "valT2", xyz: "xyz"),
    ];

    var result = toJsonAs
        .map(
          (e) => e.toJsonCustom({
            A: (A x) => x.toJson(),
            B: (B x) => x.toJson(),
            C: (C x) => x.toJson(),
          }),
        )
        .toList();

    var expected = [
      {'id': 'x', '_className_': 'A', '_T1_': 'String'},
      {'id': 1, '_className_': 'A', '_T1_': 'int'},
      {
        'id': '2',
        'valT1': 'myString',
        'valT2': 5,
        '_className_': 'B',
        '_T1_': 'String',
        '_T2_': 'int',
      },
      {
        'id': 'id',
        'valT1': 'valT1',
        'valT2': 'valT2',
        'xyz': 'xyz',
        '_className_': 'C',
        '_T1_': 'String',
        '_T2_': 'String',
      },
    ];

    expect(result, expected);
  });

  test("2 fromJson as A", () {
    var json = [
      {'id': 'x', '_className_': 'A', '_T1_': 'String'},
      {'id': 1, '_className_': 'A', '_T1_': 'int'},
      {
        'id': '2',
        'valT1': 'myString',
        'valT2': 5,
        '_className_': 'B',
        '_T1_': 'String',
        '_T2_': 'int',
      },
      {
        'id': 'id',
        'valT1': 'valT1',
        'valT2': 'valT2',
        'xyz': 'xyz',
        '_className_': 'C',
        '_T1_': 'String',
        '_T2_': 'String',
      },
    ];

    A_Generics_Sing().fns = {
      ["String"]: (Map<String, dynamic> json) =>
          _$AFromJson<String>(json, (x) => x as String),
      ["int"]: (Map<String, dynamic> json) =>
          _$AFromJson<int>(json, (x) => x as int),
    };

    B_Generics_Sing().fns = {
      ["String", "int"]: (Map<String, dynamic> json) =>
          _$BFromJson<String, int>(json, (x) => x as String, (x) => x as int),
    };

    C_Generics_Sing().fns = {
      ["String", "String"]: (Map<String, dynamic> json) =>
          _$CFromJson<String, String>(
            json,
            (x) => x as String,
            (x) => x as String,
          ),
    };

    var result = json.map((e) => A.fromJson(e)).toList();

    var expected = [
      A<String>(id: "x"),
      A<int>(id: 1),
      B<String, int>(id: "2", valT1: "myString", valT2: 5),
      C<String, String>(id: "id", valT1: "valT1", valT2: "valT2", xyz: "xyz"),
    ];

    expect(result, expected);
    expect(expected[0].runtimeType, A<String>);
    expect(expected[1].runtimeType, A<int>);
    expect(expected[2].runtimeType, B<String, int>);
    expect(expected[3].runtimeType, C<String, String>);
  });

  test("3 toJson as B", () {
    var toJsonBs = [
      B<String, String>(id: "2", valT1: "myString", valT2: "5"),
      C<String, String>(id: "id", valT1: "valT1", valT2: "valT2", xyz: "xyz"),
    ];

    var result = toJsonBs
        .map(
          (e) =>
              e.toJsonCustom({B: (B x) => x.toJson(), C: (C x) => x.toJson()}),
        )
        .toList();

    var expected = [
      {
        'id': '2',
        'valT1': 'myString',
        'valT2': '5',
        '_className_': 'B',
        '_T1_': 'String',
        '_T2_': 'String',
      },
      {
        'id': 'id',
        'valT1': 'valT1',
        'valT2': 'valT2',
        'xyz': 'xyz',
        '_className_': 'C',
        '_T1_': 'String',
        '_T2_': 'String',
      },
    ];

    expect(result, expected);
  });

  test("4 fromJson as A", () {
    var json = [
      {
        'id': '2',
        'valT1': 'myString',
        'valT2': '5',
        '_className_': 'B',
        '_T1_': 'String',
        '_T2_': 'String',
      },
      {
        'id': 'id',
        'valT1': 'valT1',
        'valT2': 'valT2',
        'xyz': 'xyz',
        '_className_': 'C',
        '_T1_': 'String',
        '_T2_': 'String',
      },
    ];

    B_Generics_Sing().fns = {
      ["String", "String"]: (Map<String, dynamic> json) =>
          _$BFromJson<String, String>(
            json,
            (x) => x as String,
            (x) => x as String,
          ),
    };

    C_Generics_Sing().fns = {
      ["String", "String"]: (Map<String, dynamic> json) =>
          _$CFromJson<String, String>(
            json,
            (x) => x as String,
            (x) => x as String,
          ),
    };

    var result = json.map((e) => A.fromJson(e)).toList();

    var expected = [
      B<String, String>(id: "2", valT1: "myString", valT2: "5"),
      C<String, String>(id: "id", valT1: "valT1", valT2: "valT2", xyz: "xyz"),
    ];

    expect(result, expected);
    expect(expected[0].runtimeType, B<String, String>);
    expect(expected[1].runtimeType, C<String, String>);
  });
}

@Morphy(generateJson: true, explicitSubTypes: [$C, $B])
abstract class $A<T1> {
  T1 get id;
}

@Morphy(generateJson: true, explicitSubTypes: [$C])
abstract class $B<T1, T2> implements $A<T1> {
  T1 get valT1;

  T2 get valT2;
}

@Morphy(generateJson: true)
abstract class $C<T1, T2> implements $B<T1, T2> {
  String get xyz;
}
