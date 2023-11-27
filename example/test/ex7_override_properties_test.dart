import 'package:test/test.dart';
import 'package:morphy/morphy.dart';

part 'ex7_override_properties_test.morphy.dart';

//CLASS B OVERRIDES A PROPERTY OF CLASS A
//BUG!!! if you use explicitSubTypes

// @Morphy(explicitSubTypes: [$C, $B]) - this causes an error
@Morphy()
abstract class $A {
  Person get a;
}

@morphy
abstract class $B implements $A {
  Employee get a;
}

@morphy
abstract class $C implements $B {
  Manager get a;
}

main() {
  test("1", () {
    var a = A(a: Person("bob"));
    var b = B(a: Employee("bob", "123"));
    var c = C(a: Manager("bob", "123", "Big boss"));

    expect(a.a.name, "bob");
    expect(b.a.name, "bob");
    expect(b.a.id, "123");
    expect(c.a.name, "bob");
    expect(c.a.id, "123");
    expect(c.a.managerType, "Big boss");
  });

  test("2 aa copy with", () {
    var a = A(a: Person("1"));
    var a_copy = a.copyWith_A(a: Opt(Person("X")));
    expect(a_copy.toString(), "(A-a:X)");
  });

  test("2 ba copy with", () {
    var b = B(a: Employee("1", "2"));
    var ba_copy = b.copyWith_A(a: Opt(Employee("X", "Y")));
    expect(ba_copy.toString(), "(B-a:X|Y)");
  });

  test("3 bb copy with", () {
    var b = B(a: Employee("1", "2"));
    var bb_copy = b.copyWith_B(a: Opt(Employee("X", "Y")));
    expect(bb_copy.toString(), "(B-a:X|Y)");
  });

  test("4 ca copy with", () {
    var c = C(a: Manager("1", "2", "3"));
    var ca_copy = c.copyWith_A(a: Opt(Manager("X", "Y", "Z")));
    expect(ca_copy.toString(), "(C-a:X|Y|Z)");
  });

  test("5 cb copy with", () {
    var c = C(a: Manager("1", "2", "3"));
    var cb_copy = c.copyWith_B(a: Opt(Manager("X", "Y", "Z")));
    expect(cb_copy.toString(), "(C-a:X|Y|Z)");
  });

  test("6 cc copy with", () {
    var c = C(a: Manager("1", "2", "3"));
    var cc_copy = c.copyWith_C(a: Opt(Manager("X", "Y", "Z")));
    expect(cc_copy.toString(), "(C-a:X|Y|Z)");
  });
}

class Person {
  final String name;
  Person(this.name);
  String toString() => name;
}

class Employee implements Person {
  final String name;
  final String id;
  Employee(this.name, this.id);
  String toString() => name + "|" + id.toString();
}

class Manager implements Employee {
  final String name;
  final String id;
  final String managerType;
  Manager(this.name, this.id, this.managerType);
  String toString() => name + "|" + id + "|" + managerType;
}
