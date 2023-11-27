// // ignore_for_file: unnecessary_cast
//
// import 'package:json_annotation/json_annotation.dart';
// import 'package:test/test.dart';
//
// part 'ex51_x_alternative_design_manual_test.g.dart';
//
// main() {
//   test("1 fromJson", () {
//     var jsonList = [
//       {'id': '1', '_className_': 'A'},
//       {'id': '2', 'blah': 'sdf', '_className_': 'B<dynamic>', '_T_': 'String'},
//       {
//         'id': '2',
//         'blah': {'xyz': 'my custom', '_className_': 'X'},
//         '_className_': 'B<dynamic>',
//         '_T_': 'X'
//       }
//     ];
//
//     jsonToGenericFunctions_A = {'X': (x) => X.fromJson(x as Map<String, dynamic>)};
//
//     var result = jsonList.map((e) => A.fromJson(e)).toList();
//
//     var expected = [
//       A(id: "1"),
//       B(id: "2", blah: "sdf"),
//       B(id: "2", blah: X(xyz: "my custom")),
//     ];
//
//     var blah = expected[0].runtimeType;
//     var blah2 = expected[1].runtimeType;
//     var blah3 = expected[2].runtimeType;
//
//     expect(result, expected);
//   });
// }
//
// abstract class $A {
//   String get id;
// }
//
// abstract class $B<T> implements $A {
//   T get blah;
// }
//
// @JsonSerializable(explicitToJson: true)
// class X {
//   final String xyz;
//
//   X({required this.xyz});
//
//   String toString() => "(X-xyz:${xyz.toString()})";
//
//   factory X.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     if (json['_className_'] == "X") {
//       return _$XFromJson(json);
//     } else {
//       throw UnsupportedError("The _className_ '${json['_className_']}' is not supported by the A.fromJson constructor.");
//     }
//   }
// }
//
// dynamic Function(Object? json) getFromJsonToGenericFn(
//   Map<String, dynamic Function(Object? json)> fns,
//   Map<String, dynamic> json,
//   String genericType,
// ) {
//   var genericName1 = json[genericType];
//   var fromJsonToGeneric_fn = fns[genericName1] ?? (x) => x;
//   return fromJsonToGeneric_fn;
// }
//
// Map<String, dynamic Function(Object? json)> jsonToGenericFunctions_A = {};
//
// @JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
// class A extends $A {
//   final String id;
//
//   A({required this.id});
//
//   String toString() => "(A-id:${id.toString()})";
//
//   factory A.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     if (json['_className_'] == "B<dynamic>") {
//       var fn_t1 = getFromJsonToGenericFn(jsonToGenericFunctions_A, json, '_T_');
//       return _$BFromJson(json, fn_t1);
//     } else if (json['_className_'] == "A") {
//       return _$AFromJson(json);
//     } else {
//       throw UnsupportedError("The _className_ '${json['_className_']}' is not supported by the A.fromJson constructor.");
//     }
//   }
// }
//
// @JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
// class B<T> extends $B<T> implements A {
//   final String id;
//   final T blah;
//
//   B({
//     required this.id,
//     required this.blah,
//   });
//
//   String toString() => "(B-id:${id.toString()}|blah:${blah.toString()})";
//
//   factory B.fromJson(
//     Map<String, dynamic> json,
//     Map<String, dynamic Function(Object? json)> types,
//   ) {
//     if (json['_className_'] == "B") {
//       var fn_t1 = getFromJsonToGenericFn(types, json, '_T_');
//       return _$BFromJson(json, fn_t1 as T Function(Object? json));
//     } else {
//       throw UnsupportedError("The _className_ '${json['_className_']}' is not supported by the B.fromJson constructor.");
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     throw Exception("not implemented");
//   }
// }
