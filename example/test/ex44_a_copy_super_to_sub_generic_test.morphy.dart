// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex44_a_copy_super_to_sub_generic_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class Super extends $Super {
  final String id;

  ///
  Super({
    required this.id,
  });
  Super._({
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
    return Super._(
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

extension $Super_changeTo_E on $Super {
  Sub changeTo_Sub<T>({
    required String description,
    required T code,
    Opt<String>? id,
  }) {
    return Sub._(
      description: description as String,
      code: code as T,
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

enum Super$ { id }

///
///implements [$Super]
///

///
class Sub<T> extends $Sub<T> implements Super {
  final String description;
  final T code;
  final String id;

  ///
  ///implements [$Super]
  ///

  ///
  Sub({
    required this.description,
    required this.code,
    required this.id,
  });
  Sub._({
    required this.description,
    required this.code,
    required this.id,
  });
  String toString() =>
      "(Sub-description:${description.toString()}|code:${code.toString()}|id:${id.toString()})";
  int get hashCode =>
      hashObjects([description.hashCode, code.hashCode, id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sub &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          code == other.code &&
          id == other.id;
  Sub copyWith_Super({
    Opt<String>? id,
  }) {
    return Sub._(
      id: id == null ? this.id as String : id.value as String,
      description: (this as Sub).description,
      code: (this as Sub).code,
    );
  }

  Sub copyWith_Sub<T>({
    Opt<String>? description,
    Opt<T>? code,
    Opt<String>? id,
  }) {
    return Sub._(
      description: description == null
          ? this.description as String
          : description.value as String,
      code: code == null ? this.code as T : code.value as T,
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

extension $Sub_changeTo_E on $Sub {}

enum Sub$ { description, code, id }
