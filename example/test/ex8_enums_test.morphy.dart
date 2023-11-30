// ignore_for_file: UNNECESSARY_CAST

part of 'ex8_enums_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///

@JsonSerializable(
  explicitToJson: true,
)
class Pet extends $Pet {
  final String type;
  final eBlim blim;

  ///
  Pet({
    required this.type,
    required this.blim,
  });
  String toString() => "(Pet-type:${type.toString()}|blim:${blim.toString()})";
  int get hashCode => hashObjects([type.hashCode, blim.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pet &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          blim == other.blim;
  Pet copyWith_Pet({
    Opt<String>? type,
    Opt<eBlim>? blim,
  }) {
    return Pet(
      type: type == null ? this.type as String : type.value as String,
      blim: blim == null ? this.blim as eBlim : blim.value as eBlim,
    );
  }

//$Pet|[]|[type:String:null, blim:eBlim:null]
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

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
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

enum Pet$ { type, blim }
