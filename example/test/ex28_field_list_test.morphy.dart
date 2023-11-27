// ignore_for_file: UNNECESSARY_CAST

part of 'ex28_field_list_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///FIELD LIST ENUM
///It is sometimes useful to have an enum of all the individual fields specified for a class.
///
///This enum is created automatically and accessed using the classname followed by a dollar.
///
///It can be useful for specifying json field names for example rather than doing so manually
///
class Pet extends $Pet {
  final String? type;
  final String name;

  ///FIELD LIST ENUM
  ///It is sometimes useful to have an enum of all the individual fields specified for a class.
  ///
  ///This enum is created automatically and accessed using the classname followed by a dollar.
  ///
  ///It can be useful for specifying json field names for example rather than doing so manually
  ///
  Pet({
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
    return Pet(
      type: type == null ? this.type as String? : type.value as String?,
      name: name == null ? this.name as String : name.value as String,
    );
  }
}

extension $Pet_changeTo_E on $Pet {}

enum Pet$ { type, name }
