// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex50_json_inheritance_generic_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

A _$AFromJson(Map<String, dynamic> json) => A(
      id: json['id'] as String,
    );

Map<String, dynamic> _$AToJson(A instance) => <String, dynamic>{
      'id': instance.id,
    };

B<T> _$BFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    B<T>(
      id: json['id'] as String,
      blah: fromJsonT(json['blah']),
    );

Map<String, dynamic> _$BToJson<T>(
  B<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'blah': toJsonT(instance.blah),
    };

X _$XFromJson(Map<String, dynamic> json) => X(
      xyz: json['xyz'] as String,
    );

Map<String, dynamic> _$XToJson(X instance) => <String, dynamic>{
      'xyz': instance.xyz,
    };
