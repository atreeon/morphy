import 'package:zikzak_morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

void main() {
  group("getCreateFromJsonFn", () {
    test("1 one generic", () {
      var json = {
        'id': '2',
        'blah': 'sdf',
        '_className_': 'B<dynamic>',
        '_T1_': 'int',
      };

      var genericTypes = ["_T1_"];

      var fns = <List<String>, dynamic Function(Map<String, dynamic>)>{
        ["int"]: (Map<String, dynamic> json) => "int",
        ["X"]: (Map<String, dynamic> json) => "X",
        ["String"]: (Map<String, dynamic> json) => "String",
      };
      var result = getFromJsonToGenericFn(fns, json, genericTypes)(json);
      var expected = "int";

      expect(result, expected);
    });

    test("2 two generics", () {
      var json = {
        'id': '2',
        'blah': 'sdf',
        '_className_': 'B<dynamic>',
        '_T1_': 'String',
        '_T2_': 'int',
      };

      var genericTypes = ["_T1_", "_T2_"];

      var fns = <List<String>, dynamic Function(Map<String, dynamic>)>{
        ["int", "int"]: (Map<String, dynamic> json) => "int, int",
        ["X", "int"]: (Map<String, dynamic> json) => "X, int",
        ["String", "int"]: (Map<String, dynamic> json) => "String, int",
      };
      var result = getFromJsonToGenericFn(fns, json, genericTypes)(json);
      var expected = "String, int";

      expect(result, expected);
    });
  });
}
