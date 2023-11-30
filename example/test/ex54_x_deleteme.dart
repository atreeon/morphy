import 'package:json_annotation/json_annotation.dart';

part 'ex54_x_deleteme.g.dart';

@JsonSerializable(constructor: "blah")
class Person {
  final String firstName, lastName;
  final DateTime? dateOfBirth;

  Person.blah({required this.firstName, required this.lastName, this.dateOfBirth});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
