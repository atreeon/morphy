import 'package:test/test.dart';
import 'package:morphy/morphy.dart';

part 'ex21_custom_constructors_test.morphy.dart';

//Where we want a custom constructor
// and hide the constructor that is usually generated
// then we add an underscore to the end of the class name.
//
//This way, outside of the file the class is defined in, the generated constructor is hidden.
//
//If we need to specify a custom constructor (very likely),
// we will then create a function inside the file the class is defined in (this file).
//
//In this example class A has an underscore thereby hiding its default constructor.
//Instead we create a function called A_DifferentConstructor.

@morphy
abstract class $A_ {
  String get a;
}

void main() {
  test("0 default value", () {
    var a = A_._(a: "my default value");
    expect(a.a, "my default value");
  });

  test("1 default value", () {
    var a = A_DifferentConstructor();
    expect(a.a, "my default value");
  });
}

A_ A_DifferentConstructor() {
  return A_._(a: "my default value");
}
