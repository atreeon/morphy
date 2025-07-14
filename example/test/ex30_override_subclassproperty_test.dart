import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex30_override_subclassproperty_test.morphy.dart';

///CLASS B OVERRIDES THE PERSON PROPERTY OF CLASS A
///USING A SUBTYPE OF PERSON, IN THIS CASE MANAGER

class Person {
  final String name;
  Person(this.name);
}

class Employee implements Person {
  final String name;
  final String id;
  Employee(this.name, this.id);
}

@Morphy(explicitToJson: false)
abstract class $A {
  Person get a;
}

@Morphy(explicitToJson: false)
abstract class $B implements $A {
  Employee get a;
}

main() {
  test("1", () {
    var a = A(a: Person("bob"));
    var b = B(a: Employee("bob", "123"));

    expect(a.a.name, "bob");
    expect(b.a.name, "bob");
    expect(b.a.id, "123");
  });
}
