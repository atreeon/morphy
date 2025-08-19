// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex48_json_with_subtype_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

A _$AFromJson(Map<String, dynamic> json) => A(
  id: json['id'] as String,
  x: X.fromJson(json['x'] as Map<String, dynamic>),
  xs: (json['xs'] as List<dynamic>)
      .map((e) => X.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AToJson(A instance) => <String, dynamic>{
  'id': instance.id,
  'x': instance.x.toJson(),
  'xs': instance.xs.map((e) => e.toJson()).toList(),
};

X _$XFromJson(Map<String, dynamic> json) => X(
  items: (json['items'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$XToJson(X instance) => <String, dynamic>{
  'items': instance.items,
};
