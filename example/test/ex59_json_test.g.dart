// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex59_json_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      age: json['age'] as int,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'age': instance.age,
    };

Athlete _$AthleteFromJson(Map<String, dynamic> json) => Athlete(
      speed: json['speed'] as int,
      age: json['age'] as int,
    );

Map<String, dynamic> _$AthleteToJson(Athlete instance) => <String, dynamic>{
      'speed': instance.speed,
      'age': instance.age,
    };

BaseballPlayer _$BaseballPlayerFromJson(Map<String, dynamic> json) =>
    BaseballPlayer(
      speed: json['speed'] as int,
      height: json['height'] as int,
      age: json['age'] as int,
    );

Map<String, dynamic> _$BaseballPlayerToJson(BaseballPlayer instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'height': instance.height,
      'age': instance.age,
    };

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      people: (json['people'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'people': instance.people.map((e) => e.toJson()).toList(),
    };
