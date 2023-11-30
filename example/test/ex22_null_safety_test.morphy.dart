// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex22_null_safety_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class Pet extends $Pet {
  final String? type;
  final String name;

  ///
  Pet({
    this.type,
    required this.name,
  });
  Pet._({
    this.type,
    required this.name,
  });
  String toString() => "(Pet-type:${type.toString()}|name:${name.toString()})";
  int get hashCode => hashObjects([type.hashCode, name.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pet &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          name == other.name;
  Pet copyWith_Pet({
    Opt<String?>? type,
    Opt<String>? name,
  }) {
    return Pet._(
      type: type == null ? this.type as String? : type.value as String?,
      name: name == null ? this.name as String : name.value as String,
    );
  }
}

extension $Pet_changeTo_E on $Pet {}

enum Pet$ { type, name }
