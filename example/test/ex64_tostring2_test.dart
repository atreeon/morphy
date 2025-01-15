import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex64_tostring2_test.morphy.dart';

//TOSTRING2 CREATES A RECREATABLE STRING

@morphy
abstract class $Pet {
  String get type;
}

@morphy
abstract class $Person {
  int get age;

  int? get numberOfHouses;

  String get name;

  String? get nickName;

  DateTime get dob;

  DateTime? get weddingAniversary;

  $Pet get pet;

  $Pet? get petNo2;
}

main() {
  test("1", () {
    var a = Pet(type: "cat");

    expect(a.toString2(), "Pet(type:\"cat\")");
  });

  test("1", () {
    var a = Person(
      age: 10,
      name: "John",
      nickName: "Jboy",
      dob: DateTime(2025, 1, 15, 18, 3, 3, 301224),
      weddingAniversary: DateTime(2025, 1, 15, 18, 1, 3, 301224),
      pet: Pet(type: "cat"),
      numberOfHouses: 2,
      petNo2: Pet(type: "dog"),
    );
    var b = Person(
      age: 10,
      name: "John",
      nickName: null,
      dob: DateTime(2025, 1, 15, 18, 31, 3, 301224),
      weddingAniversary: null,
      pet: Pet(type: "cat"),
      numberOfHouses: null,
      petNo2: null,
    );
    // print(a.toString2());
    // print(b.toString2());

    var recreateA = Person(age:10,numberOfHouses:2 ,name:"John",nickName:"Jboy" ,dob:DateTime.parse("2025-01-15 18:08:04.224"),weddingAniversary:DateTime.parse("2025-01-15 18:06:04.224") ,pet:Pet(type:"cat"),petNo2:Pet(type:"dog"));
    var recreateB = Person(age:10,numberOfHouses:null,name:"John",nickName:null,dob:DateTime.parse("2025-01-15 18:36:04.224"),weddingAniversary:null,pet:Pet(type:"cat"),petNo2:null);

    expect(a.toString(), recreateA.toString());
    expect(b.toString(), recreateB.toString());

    expect(a, recreateA);
    expect(b, recreateB);
  });
}
