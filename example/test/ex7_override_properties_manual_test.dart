import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

// ignore_for_file: UNNECESSARY_CAST

//CLASS B OVERRIDES A PROPERTY OF CLASS A

abstract class $A {
  Person get a;
}

class A extends $A {
  final Person a;
  A({
    required this.a,
  });

  String toString() => "(A-a:$a)";

  A copyWith_A({
    Opt<Person>? a,
  }) {
    return A(
      a: a == null ? this.a as Person : a.value as Person,
    );
  }
}

abstract class $B implements $A {
  Employee get a;
}

class B extends $B implements A {
  final Employee a;
  B({
    required this.a,
  });

  String toString() => "(B-a:$a)";

  B copyWith_A({
    Opt<Person>? a,
  }) {
    return B(
      a: a == null ? this.a as Employee : a.value as Employee,
    );
  }

  B copyWith_B({
    Opt<Employee>? a,
  }) {
    return B(
      a: a == null ? this.a as Employee : a.value as Employee,
    );
  }
}

abstract class $C implements $B {
  Manager get a;
}

class C extends $C implements B {
  final Manager a;
  C({
    required this.a,
  });

  String toString() => "(C-a:$a)";

  C copyWith_A({
    Opt<Person>? a,
  }) {
    return C(
      a: a == null ? this.a as Manager : a.value as Manager,
    );
  }

  C copyWith_B({
    Opt<Employee>? a,
  }) {
    return C(
      a: a == null ? this.a as Manager : a.value as Manager,
    );
  }

  C copyWith_C({
    Opt<Manager>? a,
  }) {
    return C(
      a: a == null ? this.a as Manager : a.value as Manager,
    );
  }
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

  String toString() => "$name|$id";
}

class Manager implements Employee {
  final String name;
  final String id;
  final String managerType;
  Manager(this.name, this.id, this.managerType);

  String toString() => "$name|$id|$managerType";
}
