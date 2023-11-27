// ignore_for_file: UNNECESSARY_CAST

part of 'ex1_simple_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class Pet extends $Pet {
  final String type;

  ///
  Pet({
    required this.type,
  });
  String toString() => "(Pet-type:${type.toString()})";
  int get hashCode => hashObjects([type.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pet && runtimeType == other.runtimeType && type == other.type;
  Pet copyWith_Pet({
    Opt<String>? type,
  }) {
    return Pet(
      type: type == null ? this.type as String : type.value as String,
    );
  }
}

extension $Pet_changeTo_E on $Pet {}

enum Pet$ { type }
