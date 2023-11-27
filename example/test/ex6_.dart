//import 'package:test/test.dart';
//import 'package:morphy/morphy.dart';
//import 'package:meta/meta.dart';
//
//part 'ex6_test.morphy.dart';
//
////CURRENTLY NOT ALLOWING CUSTOM GETTERS (CAN JUST USE A FUNCTION)
////  this is where mixins would have been a better approach
//
//@morphy
//abstract class $A {
//  String get z;
//
//  const $A();
//}
//
//@morphy
//abstract class $B {
//  String get y;
//  String get z => y;
//
//  const $B();
//}
//
//main() {
//  test("1", () {
//    var a = $B(type: "cat");
//
//    expect(a.type, "cat");
//  });
//}
