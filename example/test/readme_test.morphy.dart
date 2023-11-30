// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'readme_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///

@JsonSerializable(
  explicitToJson: true,
)
class Pet extends $Pet {
  final String name;
  final int age;

  ///
  Pet({
    required this.name,
    required this.age,
  });
  Pet._({
    required this.name,
    required this.age,
  });
  String toString() => "(Pet-name:${name.toString()}|age:${age.toString()})";
  int get hashCode => hashObjects([name.hashCode, age.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pet &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age;
  Pet copyWith_Pet({
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Pet._(
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
    );
  }

//$Cat|[]|[whiskerLength:double:$Cat, name:String:$Pet, age:int:$Pet]$Pet|[]|[name:String:null, age:int:null]
//$Cat|[]|[whiskerLength:double:$Cat, name:String:$Pet, age:int:$Pet]
  factory Pet.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Cat") {
      return _$CatFromJson(
        json,
      );
    } else if (json['_className_'] == "Pet") {
      return _$PetFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Pet.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$PetToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Pet';

    return data;
  }
}

extension $Pet_changeTo_E on $Pet {
  Cat changeTo_Cat({
    required double whiskerLength,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Cat._(
      whiskerLength: whiskerLength as double,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
    );
  }
}

enum Pet$ { name, age }

///
///implements [$Dog]
///

///
///implements [$Cat]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class FrankensteinsDogCat extends $FrankensteinsDogCat implements Dog, Cat {
  final double whiskerLength;
  final String woofSound;
  final String name;
  final int age;

  ///
  ///implements [$Dog]
  ///

  ///
  ///implements [$Cat]
  ///

  ///
  FrankensteinsDogCat({
    required this.whiskerLength,
    required this.woofSound,
    required this.name,
    required this.age,
  });
  FrankensteinsDogCat._({
    required this.whiskerLength,
    required this.woofSound,
    required this.name,
    required this.age,
  });
  String toString() =>
      "(FrankensteinsDogCat-whiskerLength:${whiskerLength.toString()}|woofSound:${woofSound.toString()}|name:${name.toString()}|age:${age.toString()})";
  int get hashCode => hashObjects([
        whiskerLength.hashCode,
        woofSound.hashCode,
        name.hashCode,
        age.hashCode
      ]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrankensteinsDogCat &&
          runtimeType == other.runtimeType &&
          whiskerLength == other.whiskerLength &&
          woofSound == other.woofSound &&
          name == other.name &&
          age == other.age;
  FrankensteinsDogCat copyWith_Dog({
    Opt<String>? woofSound,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return FrankensteinsDogCat._(
      woofSound: woofSound == null
          ? this.woofSound as String
          : woofSound.value as String,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
      whiskerLength: (this as FrankensteinsDogCat).whiskerLength,
    );
  }

  FrankensteinsDogCat copyWith_Pet({
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return FrankensteinsDogCat._(
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
      whiskerLength: (this as FrankensteinsDogCat).whiskerLength,
      woofSound: (this as FrankensteinsDogCat).woofSound,
    );
  }

  FrankensteinsDogCat copyWith_Cat({
    Opt<double>? whiskerLength,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return FrankensteinsDogCat._(
      whiskerLength: whiskerLength == null
          ? this.whiskerLength as double
          : whiskerLength.value as double,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
      woofSound: (this as FrankensteinsDogCat).woofSound,
    );
  }

  FrankensteinsDogCat copyWith_FrankensteinsDogCat({
    Opt<double>? whiskerLength,
    Opt<String>? woofSound,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return FrankensteinsDogCat._(
      whiskerLength: whiskerLength == null
          ? this.whiskerLength as double
          : whiskerLength.value as double,
      woofSound: woofSound == null
          ? this.woofSound as String
          : woofSound.value as String,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
    );
  }

//$Dog|[]|[woofSound:String:$Dog, name:String:$Pet, age:int:$Pet]$Pet|[]|[name:String:$Pet, age:int:$Pet]$Cat|[]|[whiskerLength:double:$Cat, name:String:$Pet, age:int:$Pet]$FrankensteinsDogCat|[]|[whiskerLength:double:null, woofSound:String:null, name:String:null, age:int:null]
//
  factory FrankensteinsDogCat.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "FrankensteinsDogCat") {
      return _$FrankensteinsDogCatFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the FrankensteinsDogCat.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$FrankensteinsDogCatToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'FrankensteinsDogCat';

    return data;
  }
}

extension $FrankensteinsDogCat_changeTo_E on $FrankensteinsDogCat {}

enum FrankensteinsDogCat$ { whiskerLength, woofSound, name, age }

///
///implements [$Pet]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class Cat extends $Cat implements Pet {
  final double whiskerLength;
  final String name;
  final int age;

  ///
  ///implements [$Pet]
  ///

  ///
  Cat({
    required this.whiskerLength,
    required this.name,
    required this.age,
  });
  Cat._({
    required this.whiskerLength,
    required this.name,
    required this.age,
  });
  String toString() =>
      "(Cat-whiskerLength:${whiskerLength.toString()}|name:${name.toString()}|age:${age.toString()})";
  int get hashCode =>
      hashObjects([whiskerLength.hashCode, name.hashCode, age.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          whiskerLength == other.whiskerLength &&
          name == other.name &&
          age == other.age;
  Cat copyWith_Pet({
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Cat._(
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
      whiskerLength: (this as Cat).whiskerLength,
    );
  }

  Cat copyWith_Cat({
    Opt<double>? whiskerLength,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Cat._(
      whiskerLength: whiskerLength == null
          ? this.whiskerLength as double
          : whiskerLength.value as double,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
    );
  }

//$Pet|[]|[name:String:$Pet, age:int:$Pet]$Cat|[]|[whiskerLength:double:null, name:String:null, age:int:null]
//
  factory Cat.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Cat") {
      return _$CatFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Cat.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$CatToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Cat';

    return data;
  }
}

extension $Cat_changeTo_E on $Cat {}

enum Cat$ { whiskerLength, name, age }

///
///implements [$Pet]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class Dog extends $Dog implements Pet {
  final String woofSound;
  final String name;
  final int age;

  ///
  ///implements [$Pet]
  ///

  ///
  Dog({
    required this.woofSound,
    required this.name,
    required this.age,
  });
  Dog._({
    required this.woofSound,
    required this.name,
    required this.age,
  });
  String toString() =>
      "(Dog-woofSound:${woofSound.toString()}|name:${name.toString()}|age:${age.toString()})";
  int get hashCode =>
      hashObjects([woofSound.hashCode, name.hashCode, age.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog &&
          runtimeType == other.runtimeType &&
          woofSound == other.woofSound &&
          name == other.name &&
          age == other.age;
  Dog copyWith_Pet({
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Dog._(
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
      woofSound: (this as Dog).woofSound,
    );
  }

  Dog copyWith_Dog({
    Opt<String>? woofSound,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Dog._(
      woofSound: woofSound == null
          ? this.woofSound as String
          : woofSound.value as String,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
    );
  }

//$Pet|[]|[name:String:$Pet, age:int:$Pet]$Dog|[]|[woofSound:String:null, name:String:null, age:int:null]
//
  factory Dog.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Dog") {
      return _$DogFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Dog.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$DogToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Dog';

    return data;
  }
}

extension $Dog_changeTo_E on $Dog {}

enum Dog$ { woofSound, name, age }

///
///implements [$Pet]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class Fish extends $Fish implements Pet {
  final eFishColour fishColour;
  final String name;
  final int age;

  ///
  ///implements [$Pet]
  ///

  ///
  Fish({
    required this.fishColour,
    required this.name,
    required this.age,
  });
  Fish._({
    required this.fishColour,
    required this.name,
    required this.age,
  });
  String toString() =>
      "(Fish-fishColour:${fishColour.toString()}|name:${name.toString()}|age:${age.toString()})";
  int get hashCode =>
      hashObjects([fishColour.hashCode, name.hashCode, age.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Fish &&
          runtimeType == other.runtimeType &&
          fishColour == other.fishColour &&
          name == other.name &&
          age == other.age;
  Fish copyWith_Pet({
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Fish._(
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
      fishColour: (this as Fish).fishColour,
    );
  }

  Fish copyWith_Fish({
    Opt<eFishColour>? fishColour,
    Opt<String>? name,
    Opt<int>? age,
  }) {
    return Fish._(
      fishColour: fishColour == null
          ? this.fishColour as eFishColour
          : fishColour.value as eFishColour,
      name: name == null ? this.name as String : name.value as String,
      age: age == null ? this.age as int : age.value as int,
    );
  }

//$Pet|[]|[name:String:$Pet, age:int:$Pet]$Fish|[]|[fishColour:eFishColour:null, name:String:null, age:int:null]
//
  factory Fish.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Fish") {
      return _$FishFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Fish.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$FishToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Fish';

    return data;
  }
}

extension $Fish_changeTo_E on $Fish {}

enum Fish$ { fishColour, name, age }

///
class PetOwner<TPet extends $Pet> extends $PetOwner<TPet> {
  final String ownerName;
  final TPet pet;

  ///
  PetOwner({
    required this.ownerName,
    required this.pet,
  });
  PetOwner._({
    required this.ownerName,
    required this.pet,
  });
  String toString() =>
      "(PetOwner-ownerName:${ownerName.toString()}|pet:${pet.toString()})";
  int get hashCode => hashObjects([ownerName.hashCode, pet.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetOwner &&
          runtimeType == other.runtimeType &&
          ownerName == other.ownerName &&
          pet == other.pet;
  PetOwner copyWith_PetOwner<TPet extends $Pet>({
    Opt<String>? ownerName,
    Opt<TPet>? pet,
  }) {
    return PetOwner._(
      ownerName: ownerName == null
          ? this.ownerName as String
          : ownerName.value as String,
      pet: pet == null ? this.pet as TPet : pet.value as TPet,
    );
  }
}

extension $PetOwner_changeTo_E on $PetOwner {}

enum PetOwner$ { ownerName, pet }

///
class A extends $A {
  final String val;
  final DateTime timestamp;

  ///
  A._({
    required this.val,
    required this.timestamp,
  });
  String toString() =>
      "(A-val:${val.toString()}|timestamp:${timestamp.toString()})";
  int get hashCode => hashObjects([val.hashCode, timestamp.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A &&
          runtimeType == other.runtimeType &&
          val == other.val &&
          timestamp == other.timestamp;
  A copyWith_A({
    Opt<String>? val,
    Opt<DateTime>? timestamp,
  }) {
    return A._(
      val: val == null ? this.val as String : val.value as String,
      timestamp: timestamp == null
          ? this.timestamp as DateTime
          : timestamp.value as DateTime,
    );
  }
}

extension $A_changeTo_E on $A {}

enum A$ { val, timestamp }

///
class B extends $B {
  final String val;
  final String? optional;

  ///
  B({
    required this.val,
    this.optional,
  });
  B._({
    required this.val,
    this.optional,
  });
  String toString() =>
      "(B-val:${val.toString()}|optional:${optional.toString()})";
  int get hashCode => hashObjects([val.hashCode, optional.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          val == other.val &&
          optional == other.optional;
  B copyWith_B({
    Opt<String>? val,
    Opt<String?>? optional,
  }) {
    return B._(
      val: val == null ? this.val as String : val.value as String,
      optional: optional == null
          ? this.optional as String?
          : optional.value as String?,
    );
  }
}

extension $B_changeTo_E on $B {}

enum B$ { val, optional }

///

@JsonSerializable(
  explicitToJson: true,
)
class X extends $X {
  final String val;

  ///
  X({
    required this.val,
  });
  X._({
    required this.val,
  });
  String toString() => "(X-val:${val.toString()})";
  int get hashCode => hashObjects([val.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is X && runtimeType == other.runtimeType && val == other.val;
  X copyWith_X({
    Opt<String>? val,
  }) {
    return X._(
      val: val == null ? this.val as String : val.value as String,
    );
  }

//$Z|[]|[valZ:double:$Z, valY:int:$Y, val:String:$X]$Y|[]|[valY:int:$Y, val:String:$X]$X|[]|[val:String:null]
//$Z|[]|[valZ:double:$Z, valY:int:$Y, val:String:$X]
//$Y|[]|[valY:int:$Y, val:String:$X]
  factory X.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Z") {
      return _$ZFromJson(
        json,
      );
    } else if (json['_className_'] == "Y") {
      return _$YFromJson(
        json,
      );
    } else if (json['_className_'] == "X") {
      return _$XFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the X.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$XToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'X';

    return data;
  }
}

extension $X_changeTo_E on $X {
  Z changeTo_Z({
    required double valZ,
    required int valY,
    Opt<String>? val,
  }) {
    return Z._(
      valZ: valZ as double,
      valY: valY as int,
      val: val == null ? this.val as String : val.value as String,
    );
  }

  Y changeTo_Y({
    required int valY,
    Opt<String>? val,
  }) {
    return Y._(
      valY: valY as int,
      val: val == null ? this.val as String : val.value as String,
    );
  }
}

enum X$ { val }

///
///implements [$X]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class Y extends $Y implements X {
  final String val;
  final int valY;

  ///
  ///implements [$X]
  ///

  ///
  Y({
    required this.val,
    required this.valY,
  });
  Y._({
    required this.val,
    required this.valY,
  });
  String toString() => "(Y-val:${val.toString()}|valY:${valY.toString()})";
  int get hashCode => hashObjects([val.hashCode, valY.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Y &&
          runtimeType == other.runtimeType &&
          val == other.val &&
          valY == other.valY;
  Y copyWith_X({
    Opt<String>? val,
  }) {
    return Y._(
      val: val == null ? this.val as String : val.value as String,
      valY: (this as Y).valY,
    );
  }

  Y copyWith_Y({
    Opt<String>? val,
    Opt<int>? valY,
  }) {
    return Y._(
      val: val == null ? this.val as String : val.value as String,
      valY: valY == null ? this.valY as int : valY.value as int,
    );
  }

//$X|[]|[val:String:$X]$Z|[]|[valZ:double:$Z, valY:int:$Y, val:String:$X]$Y|[]|[val:String:null, valY:int:null]
//$Z|[]|[valZ:double:$Z, valY:int:$Y, val:String:$X]
  factory Y.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Z") {
      return _$ZFromJson(
        json,
      );
    } else if (json['_className_'] == "Y") {
      return _$YFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Y.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$YToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Y';

    return data;
  }
}

extension $Y_changeTo_E on $Y {
  Z changeTo_Z({
    required double valZ,
    Opt<String>? val,
    Opt<int>? valY,
  }) {
    return Z._(
      valZ: valZ as double,
      val: val == null ? this.val as String : val.value as String,
      valY: valY == null ? this.valY as int : valY.value as int,
    );
  }
}

enum Y$ { val, valY }

///
///implements [$Y]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class Z extends $Z implements Y {
  final String val;
  final int valY;
  final double valZ;

  ///
  ///implements [$Y]
  ///

  ///
  Z({
    required this.val,
    required this.valY,
    required this.valZ,
  });
  Z._({
    required this.val,
    required this.valY,
    required this.valZ,
  });
  String toString() =>
      "(Z-val:${val.toString()}|valY:${valY.toString()}|valZ:${valZ.toString()})";
  int get hashCode => hashObjects([val.hashCode, valY.hashCode, valZ.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Z &&
          runtimeType == other.runtimeType &&
          val == other.val &&
          valY == other.valY &&
          valZ == other.valZ;
  Z copyWith_Y({
    Opt<String>? val,
    Opt<int>? valY,
  }) {
    return Z._(
      val: val == null ? this.val as String : val.value as String,
      valY: valY == null ? this.valY as int : valY.value as int,
      valZ: (this as Z).valZ,
    );
  }

  Z copyWith_X({
    Opt<String>? val,
  }) {
    return Z._(
      val: val == null ? this.val as String : val.value as String,
      valY: (this as Z).valY,
      valZ: (this as Z).valZ,
    );
  }

  Z copyWith_Z({
    Opt<String>? val,
    Opt<int>? valY,
    Opt<double>? valZ,
  }) {
    return Z._(
      val: val == null ? this.val as String : val.value as String,
      valY: valY == null ? this.valY as int : valY.value as int,
      valZ: valZ == null ? this.valZ as double : valZ.value as double,
    );
  }

//$Y|[]|[valY:int:$Y, val:String:$X]$X|[]|[val:String:$X]$Z|[]|[val:String:null, valY:int:null, valZ:double:null]
//
  factory Z.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Z") {
      return _$ZFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Z.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$ZToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Z';

    return data;
  }
}

extension $Z_changeTo_E on $Z {}

enum Z$ { val, valY, valZ }
