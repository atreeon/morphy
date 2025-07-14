// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex53_abstract_json_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo2 _$Todo2FromJson(Map<String, dynamic> json) => Todo2(
  title: json['title'] as String,
  id: json['id'] as String?,
  description: json['description'] as String,
);

Map<String, dynamic> _$Todo2ToJson(Todo2 instance) => <String, dynamic>{
  'title': instance.title,
  'id': instance.id,
  'description': instance.description,
};

Todo2_incomplete _$Todo2_incompleteFromJson(Map<String, dynamic> json) =>
    Todo2_incomplete(
      title: json['title'] as String,
      id: json['id'] as String?,
      description: json['description'] as String,
    );

Map<String, dynamic> _$Todo2_incompleteToJson(Todo2_incomplete instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'description': instance.description,
    };

Todo2_complete _$Todo2_completeFromJson(Map<String, dynamic> json) =>
    Todo2_complete(
      title: json['title'] as String,
      id: json['id'] as String?,
      description: json['description'] as String,
      completedDate: DateTime.parse(json['completedDate'] as String),
    );

Map<String, dynamic> _$Todo2_completeToJson(Todo2_complete instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'description': instance.description,
      'completedDate': instance.completedDate.toIso8601String(),
    };
