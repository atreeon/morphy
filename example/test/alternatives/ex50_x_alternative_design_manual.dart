// // ignore_for_file: unnecessary_cast
//
// import 'package:json_annotation/json_annotation.dart';
// import 'package:test/test.dart';
//
// part 'ex50_x_alternative_design_manual_test.g.dart';
//
// /// When using generics that require a
//
// B<String> B_String({required String id, required String blah}) {
//   return B<String>(id: id, blah: blah, toJsonT: (x) => x as String);
// }
//
// B<X> B_X({required String id, required X blah}) {
//   return B<X>(id: id, blah: blah, toJsonT: (x) => x.toJson());
// }
//
// main() {
//   test("1 toJson", () {
//     var aList = [
//       A(id: "1"),
//       B_String(id: "2", blah: "sdf"),
//       B_X(id: "2", blah: X(xyz: "my custom")),
//     ];
//
//     var result = aList.map((e) => e.toJson()).toList();
//
//     var expected = [
//       {'id': '1', '_className_': 'A'},
//       {'id': '2', 'blah': 'sdf', '_className_': 'B<dynamic>'},
//       {
//         'id': '2',
//         'blah': {'xyz': 'my custom'},
//         '_className_': 'B<dynamic>'
//       }
//     ];
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
//   factory X.fromJson(Map<String, dynamic> json) {
//     throw Exception("not implemented");
//   }
//
//   Map<String, dynamic> toJson() => _$XToJson(this);
// }
//
// @JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
// class A extends $A {
//   final String id;
//
//   A({required this.id});
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = _$AToJson(this);
//
//     // Adding custom key-value pair
//     data['_className_'] = '$A';
//
//     return data;
//   }
// }
//
// @JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
// class B<T> extends $B<T> implements A {
//   final String id;
//   final T blah;
//
//   //1.
//   final Object? Function(T value)? _toJsonT;
//
//   B({
//     required this.id,
//     required this.blah,
//
//     //2.
//     Object? Function(T value)? toJsonT,
//   })
//
//   //3.
//   : this._toJsonT = toJsonT;
//
//   factory B.fromJson(Map<String, dynamic> json) {
//     throw Exception("not implemented");
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = _$BToJson(
//       this,
//
//       //4.
//       _toJsonT ?? (x) => x as T,
//     );
//
//     // Adding custom key-value pair
//     data['_className_'] = '$B';
//
//     return data;
//   }
// }
