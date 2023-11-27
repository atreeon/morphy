// ignore_for_file: UNNECESSARY_CAST

part of 'ex45_copyWithPolymorphic_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

/// ChangeTo_ function is used to change the underlying type from one to another
/// To enable ChangeTo on a class we need to add the type to the list of explicitSubTypes in the annotation
/// To copy from a super class to a sub we will always change the underlining type.
/// Therefore we will always use changeTo_
/// A reminder that copyWith always retains the original type
/// even though it can be used polymorphically; ie on super and sub classes.
///
class Super extends $Super {
  final String id;

  /// ChangeTo_ function is used to change the underlying type from one to another
  /// To enable ChangeTo on a class we need to add the type to the list of explicitSubTypes in the annotation
  /// To copy from a super class to a sub we will always change the underlining type.
  /// Therefore we will always use changeTo_
  /// A reminder that copyWith always retains the original type
  /// even though it can be used polymorphically; ie on super and sub classes.
  ///
  Super({
    required this.id,
  });
  String toString() => "(Super-id:${id.toString()})";
  int get hashCode => hashObjects([id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Super && runtimeType == other.runtimeType && id == other.id;
  Super copyWith_Super({
    Opt<String>? id,
  }) {
    return Super(
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

extension $Super_changeTo_E on $Super {
  Sub changeTo_Sub({
    required String description,
    Opt<String>? id,
  }) {
    return Sub(
      description: description as String,
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

enum Super$ { id }

///
///implements [$Super]
///

/// ChangeTo_ function is used to change the underlying type from one to another
/// To enable ChangeTo on a class we need to add the type to the list of explicitSubTypes in the annotation
/// To copy from a super class to a sub we will always change the underlining type.
/// Therefore we will always use changeTo_
/// A reminder that copyWith always retains the original type
/// even though it can be used polymorphically; ie on super and sub classes.
///
class Sub extends $Sub implements Super {
  final String description;
  final String id;

  ///
  ///implements [$Super]
  ///

  /// ChangeTo_ function is used to change the underlying type from one to another
  /// To enable ChangeTo on a class we need to add the type to the list of explicitSubTypes in the annotation
  /// To copy from a super class to a sub we will always change the underlining type.
  /// Therefore we will always use changeTo_
  /// A reminder that copyWith always retains the original type
  /// even though it can be used polymorphically; ie on super and sub classes.
  ///
  Sub({
    required this.description,
    required this.id,
  });
  String toString() =>
      "(Sub-description:${description.toString()}|id:${id.toString()})";
  int get hashCode => hashObjects([description.hashCode, id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sub &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          id == other.id;
  Sub copyWith_Super({
    Opt<String>? id,
  }) {
    return Sub(
      id: id == null ? this.id as String : id.value as String,
      description: (this as Sub).description,
    );
  }

  Sub copyWith_Sub({
    Opt<String>? description,
    Opt<String>? id,
  }) {
    return Sub(
      description: description == null
          ? this.description as String
          : description.value as String,
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

extension $Sub_changeTo_E on $Sub {}

enum Sub$ { description, id }
