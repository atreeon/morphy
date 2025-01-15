// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readme_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
    };

FrankensteinsDogCat _$FrankensteinsDogCatFromJson(Map<String, dynamic> json) =>
    FrankensteinsDogCat(
      whiskerLength: (json['whiskerLength'] as num).toDouble(),
      woofSound: json['woofSound'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$FrankensteinsDogCatToJson(
        FrankensteinsDogCat instance) =>
    <String, dynamic>{
      'whiskerLength': instance.whiskerLength,
      'woofSound': instance.woofSound,
      'name': instance.name,
      'age': instance.age,
    };

Cat _$CatFromJson(Map<String, dynamic> json) => Cat(
      whiskerLength: (json['whiskerLength'] as num).toDouble(),
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'whiskerLength': instance.whiskerLength,
      'name': instance.name,
      'age': instance.age,
    };

Dog _$DogFromJson(Map<String, dynamic> json) => Dog(
      woofSound: json['woofSound'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$DogToJson(Dog instance) => <String, dynamic>{
      'woofSound': instance.woofSound,
      'name': instance.name,
      'age': instance.age,
    };

Fish _$FishFromJson(Map<String, dynamic> json) => Fish(
      fishColour: $enumDecode(_$eFishColourEnumMap, json['fishColour']),
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$FishToJson(Fish instance) => <String, dynamic>{
      'fishColour': _$eFishColourEnumMap[instance.fishColour]!,
      'name': instance.name,
      'age': instance.age,
    };

const _$eFishColourEnumMap = {
  eFishColour.gold: 'gold',
  eFishColour.silver: 'silver',
  eFishColour.nemo: 'nemo',
};

X _$XFromJson(Map<String, dynamic> json) => X(
      val: json['val'] as String,
    );

Map<String, dynamic> _$XToJson(X instance) => <String, dynamic>{
      'val': instance.val,
    };

Y _$YFromJson(Map<String, dynamic> json) => Y(
      val: json['val'] as String,
      valY: (json['valY'] as num).toInt(),
    );

Map<String, dynamic> _$YToJson(Y instance) => <String, dynamic>{
      'val': instance.val,
      'valY': instance.valY,
    };

Z _$ZFromJson(Map<String, dynamic> json) => Z(
      val: json['val'] as String,
      valY: (json['valY'] as num).toInt(),
      valZ: (json['valZ'] as num).toDouble(),
    );

Map<String, dynamic> _$ZToJson(Z instance) => <String, dynamic>{
      'val': instance.val,
      'valY': instance.valY,
      'valZ': instance.valZ,
    };
