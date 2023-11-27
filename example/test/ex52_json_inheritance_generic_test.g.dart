// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex52_json_inheritance_generic_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

A<T1> _$AFromJson<T1>(
  Map<String, dynamic> json,
  T1 Function(Object? json) fromJsonT1,
) =>
    A<T1>(
      id: fromJsonT1(json['id']),
    );

Map<String, dynamic> _$AToJson<T1>(
  A<T1> instance,
  Object? Function(T1 value) toJsonT1,
) =>
    <String, dynamic>{
      'id': toJsonT1(instance.id),
    };

B<T1, T2> _$BFromJson<T1, T2>(
  Map<String, dynamic> json,
  T1 Function(Object? json) fromJsonT1,
  T2 Function(Object? json) fromJsonT2,
) =>
    B<T1, T2>(
      id: fromJsonT1(json['id']),
      valT1: fromJsonT1(json['valT1']),
      valT2: fromJsonT2(json['valT2']),
    );

Map<String, dynamic> _$BToJson<T1, T2>(
  B<T1, T2> instance,
  Object? Function(T1 value) toJsonT1,
  Object? Function(T2 value) toJsonT2,
) =>
    <String, dynamic>{
      'id': toJsonT1(instance.id),
      'valT1': toJsonT1(instance.valT1),
      'valT2': toJsonT2(instance.valT2),
    };

C<T1, T2> _$CFromJson<T1, T2>(
  Map<String, dynamic> json,
  T1 Function(Object? json) fromJsonT1,
  T2 Function(Object? json) fromJsonT2,
) =>
    C<T1, T2>(
      id: fromJsonT1(json['id']),
      valT1: fromJsonT1(json['valT1']),
      valT2: fromJsonT2(json['valT2']),
      xyz: json['xyz'] as String,
    );

Map<String, dynamic> _$CToJson<T1, T2>(
  C<T1, T2> instance,
  Object? Function(T1 value) toJsonT1,
  Object? Function(T2 value) toJsonT2,
) =>
    <String, dynamic>{
      'id': toJsonT1(instance.id),
      'valT1': toJsonT1(instance.valT1),
      'valT2': toJsonT2(instance.valT2),
      'xyz': instance.xyz,
    };
