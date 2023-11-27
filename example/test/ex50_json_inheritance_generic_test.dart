// ignore_for_file: unnecessary_cast

import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:morphy/morphy.dart';

part 'ex50_json_inheritance_generic_test.g.dart';
part 'ex50_json_inheritance_generic_test.morphy.dart';

/// When using generics that require JSON then we need to define
/// how that generic is converted into JSON.  Unfortunately we
/// must do that for every single creation of an object (see jsongenerics.png)
/// To make this a bit easier we can curry the constructors

// B<String> B_String({required String id, required String blah}) {
//   return B<String>(id: id, blah: blah, toJson_T: (x) => x as String);
// }
//
// B<X> B_X({required String id, required X blah}) {
//   return B<X>(id: id, blah: blah, toJson_T: (x) => x.toJson());
// }

main() {
  test("1 toJson", () {
    var aList = [
      A(id: "1"),
      B<String>(id: "2", blah: "sdf"),
      B<X>(id: "3", blah: X(xyz: "my custom")),
    ];

    var result = aList
        .map((e) => e.toJson_2(
              {X: (X x) => x.toJson()},
            ))
        .toList();

    var expected = [
      {'id': '1', '_className_': 'A'},
      {'id': '2', 'blah': 'sdf', '_className_': 'B', '_T_': 'String'},
      {
        'id': '3',
        'blah': {'xyz': 'my custom', '_className_': 'X'},
        '_className_': 'B',
        '_T_': 'X'
      }
    ];

    expect(result, expected);
  });
}

@Morphy(generateJson: true)
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
