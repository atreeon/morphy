// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex54_default_constructor_json_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///

abstract class Todo2 extends $$Todo2 {
  String get title;
  String get id;
  String get description;
  Todo2 copyWith_Todo2({
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
  });
//$Todo2_complete|[]|[completedDate:DateTime:$Todo2_complete, title:String:$$Todo2, id:String:$$Todo2, description:String:$$Todo2]$Todo2_incomplete|[]|[title:String:$$Todo2, id:String:$$Todo2, description:String:$$Todo2]$$Todo2|[]|[title:String:null, id:String:null, description:String:null]
//$Todo2_complete|[]|[completedDate:DateTime:$Todo2_complete, title:String:$$Todo2, id:String:$$Todo2, description:String:$$Todo2]
//$Todo2_incomplete|[]|[title:String:$$Todo2, id:String:$$Todo2, description:String:$$Todo2]
  factory Todo2.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Todo2_complete") {
      return _$Todo2_completeFromJson(
        json,
      );
    } else if (json['_className_'] == "Todo2_incomplete") {
      return _$Todo2_incompleteFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Todo2.fromJson constructor.");
    }
  }

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]);
}

extension $$Todo2_changeTo_E on $$Todo2 {
  Todo2_complete changeTo_Todo2_complete({
    required DateTime completedDate,
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
  }) {
    return Todo2_complete._(
      completedDate: completedDate as DateTime,
      title: title == null ? this.title as String : title.value as String,
      id: id == null ? this.id as String : id.value as String,
      description: description == null
          ? this.description as String
          : description.value as String,
    );
  }

  Todo2_incomplete changeTo_Todo2_incomplete({
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
  }) {
    return Todo2_incomplete._(
      title: title == null ? this.title as String : title.value as String,
      id: id == null ? this.id as String : id.value as String,
      description: description == null
          ? this.description as String
          : description.value as String,
    );
  }
}

enum Todo2$ { title, id, description }

///
///implements [$$Todo2]
///

///

@JsonSerializable(explicitToJson: true, constructor: 'forJsonDoNotUse')
class Todo2_incomplete extends $Todo2_incomplete implements Todo2 {
  final String title;
  final String id;
  final String description;

  ///
  ///implements [$$Todo2]
  ///

  ///
  Todo2_incomplete.forJsonDoNotUse({
    required this.title,
    required this.id,
    required this.description,
  });
  Todo2_incomplete._({
    required this.title,
    required this.id,
    required this.description,
  });
  String toString() =>
      "(Todo2_incomplete-title:${title.toString()}|id:${id.toString()}|description:${description.toString()})";
  int get hashCode =>
      hashObjects([title.hashCode, id.hashCode, description.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo2_incomplete &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          id == other.id &&
          description == other.description;
  Todo2_incomplete copyWith_Todo2({
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
  }) {
    return Todo2_incomplete._(
      title: title == null ? this.title as String : title.value as String,
      id: id == null ? this.id as String : id.value as String,
      description: description == null
          ? this.description as String
          : description.value as String,
    );
  }

  Todo2_incomplete copyWith_Todo2_incomplete({
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
  }) {
    return Todo2_incomplete._(
      title: title == null ? this.title as String : title.value as String,
      id: id == null ? this.id as String : id.value as String,
      description: description == null
          ? this.description as String
          : description.value as String,
    );
  }

//$$Todo2|[]|[title:String:$$Todo2, id:String:$$Todo2, description:String:$$Todo2]$Todo2_incomplete|[]|[title:String:null, id:String:null, description:String:null]
//
  factory Todo2_incomplete.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Todo2_incomplete") {
      return _$Todo2_incompleteFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Todo2_incomplete.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$Todo2_incompleteToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Todo2_incomplete';

    return data;
  }
}

extension $Todo2_incomplete_changeTo_E on $Todo2_incomplete {}

enum Todo2_incomplete$ { title, id, description }

///
///implements [$$Todo2]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class Todo2_complete extends $Todo2_complete implements Todo2 {
  final String title;
  final String id;
  final String description;
  final DateTime completedDate;

  ///
  ///implements [$$Todo2]
  ///

  ///
  Todo2_complete({
    required this.title,
    required this.id,
    required this.description,
    required this.completedDate,
  });
  Todo2_complete._({
    required this.title,
    required this.id,
    required this.description,
    required this.completedDate,
  });
  String toString() =>
      "(Todo2_complete-title:${title.toString()}|id:${id.toString()}|description:${description.toString()}|completedDate:${completedDate.toString()})";
  int get hashCode => hashObjects([
        title.hashCode,
        id.hashCode,
        description.hashCode,
        completedDate.hashCode
      ]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo2_complete &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          id == other.id &&
          description == other.description &&
          completedDate == other.completedDate;
  Todo2_complete copyWith_Todo2({
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
  }) {
    return Todo2_complete._(
      title: title == null ? this.title as String : title.value as String,
      id: id == null ? this.id as String : id.value as String,
      description: description == null
          ? this.description as String
          : description.value as String,
      completedDate: (this as Todo2_complete).completedDate,
    );
  }

  Todo2_complete copyWith_Todo2_complete({
    Opt<String>? title,
    Opt<String>? id,
    Opt<String>? description,
    Opt<DateTime>? completedDate,
  }) {
    return Todo2_complete._(
      title: title == null ? this.title as String : title.value as String,
      id: id == null ? this.id as String : id.value as String,
      description: description == null
          ? this.description as String
          : description.value as String,
      completedDate: completedDate == null
          ? this.completedDate as DateTime
          : completedDate.value as DateTime,
    );
  }

//$$Todo2|[]|[title:String:$$Todo2, id:String:$$Todo2, description:String:$$Todo2]$Todo2_complete|[]|[title:String:null, id:String:null, description:String:null, completedDate:DateTime:null]
//
  factory Todo2_complete.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Todo2_complete") {
      return _$Todo2_completeFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Todo2_complete.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$Todo2_completeToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Todo2_complete';

    return data;
  }
}

extension $Todo2_complete_changeTo_E on $Todo2_complete {}

enum Todo2_complete$ { title, id, description, completedDate }
