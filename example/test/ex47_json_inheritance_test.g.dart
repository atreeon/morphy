// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex47_json_inheritance_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

A _$AFromJson(Map<String, dynamic> json) => A(
      id: json['id'] as String,
    );

Map<String, dynamic> _$AToJson(A instance) => <String, dynamic>{
      'id': instance.id,
    };

B _$BFromJson(Map<String, dynamic> json) => B(
      id: json['id'] as String,
    );

Map<String, dynamic> _$BToJson(B instance) => <String, dynamic>{
      'id': instance.id,
    };

C _$CFromJson(Map<String, dynamic> json) => C(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CToJson(C instance) => <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
    };
