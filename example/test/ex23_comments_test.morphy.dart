// ignore_for_file: UNNECESSARY_CAST

part of 'ex23_comments_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///This is my class level comment
///
class Cat extends $Cat {
  ///Type is a thingy thing
  final String type;
  final String colour;

  ///This is my class level comment
  ///
  Cat({
    required this.type,
    required this.colour,
  });
  String toString() =>
      "(Cat-type:${type.toString()}|colour:${colour.toString()})";
  int get hashCode => hashObjects([type.hashCode, colour.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          colour == other.colour;
  Cat copyWith_Cat({
    Opt<String>? type,
    Opt<String>? colour,
  }) {
    return Cat(
      type: type == null ? this.type as String : type.value as String,
      colour: colour == null ? this.colour as String : colour.value as String,
    );
  }
}

extension $Cat_changeTo_E on $Cat {}

enum Cat$ { type, colour }
