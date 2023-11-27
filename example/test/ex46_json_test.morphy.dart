// ignore_for_file: UNNECESSARY_CAST

part of 'ex46_json_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///

@JsonSerializable(explicitToJson: true)
class Pet extends $Pet {
  final String kind;

  ///
  Pet({
    required this.kind,
  });
  String toString() => "(Pet-kind:${kind.toString()})";
  int get hashCode => hashObjects([kind.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pet && runtimeType == other.runtimeType && kind == other.kind;
  Pet copyWith_Pet({
    Opt<String>? kind,
  }) {
    return Pet(
      kind: kind == null ? this.kind as String : kind.value as String,
    );
  }

//$Pet|[]|[kind:String:null]
//
  factory Pet.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "Pet") {
      return _$PetFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the Pet.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2(Map<Type, Object? Function(Never)> fns) {
    this._fns = fns;
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$PetToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'Pet';

    return data;
  }
}

extension $Pet_changeTo_E on $Pet {}

enum Pet$ { kind }
