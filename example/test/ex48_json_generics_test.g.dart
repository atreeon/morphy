// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex48_json_generics_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

A<T> _$AFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    A<T>(
      fromJsonT(json['data']),
    );

Map<String, dynamic> _$AToJson<T>(
  A<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
    };
