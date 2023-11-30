// ignore_for_file: UNNECESSARY_CAST

part of 'ex47_json_inheritance_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///

@JsonSerializable(
  explicitToJson: true,
)
class A extends $A {
  final String id;

  ///
  A({
    required this.id,
  });
  String toString() => "(A-id:${id.toString()})";
  int get hashCode => hashObjects([id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && id == other.id;
  A copyWith_A({
    Opt<String>? id,
  }) {
    return A(
      id: id == null ? this.id as String : id.value as String,
    );
  }

//$B|[]|[id:String:$A]$C|[]|[items:List<int>:$C, id:String:$A]$A|[]|[id:String:null]
//$B|[]|[id:String:$A]
//$C|[]|[items:List<int>:$C, id:String:$A]
  factory A.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "B") {
      return _$BFromJson(
        json,
      );
    } else if (json['_className_'] == "C") {
      return _$CFromJson(
        json,
      );
    } else if (json['_className_'] == "A") {
      return _$AFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the A.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$AToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'A';

    return data;
  }
}

extension $A_changeTo_E on $A {
  B changeTo_B({
    Opt<String>? id,
  }) {
    return B(
      id: id == null ? this.id as String : id.value as String,
    );
  }

  C changeTo_C({
    required List<int> items,
    Opt<String>? id,
  }) {
    return C(
      items: items as List<int>,
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

enum A$ { id }

///
///implements [$A]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class B extends $B implements A {
  final String id;

  ///
  ///implements [$A]
  ///

  ///
  B({
    required this.id,
  });
  String toString() => "(B-id:${id.toString()})";
  int get hashCode => hashObjects([id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B && runtimeType == other.runtimeType && id == other.id;
  B copyWith_A({
    Opt<String>? id,
  }) {
    return B(
      id: id == null ? this.id as String : id.value as String,
    );
  }

  B copyWith_B({
    Opt<String>? id,
  }) {
    return B(
      id: id == null ? this.id as String : id.value as String,
    );
  }

//$A|[]|[id:String:$A]$B|[]|[id:String:null]
//
  factory B.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "B") {
      return _$BFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the B.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$BToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'B';

    return data;
  }
}

extension $B_changeTo_E on $B {}

enum B$ { id }

///
///implements [$A]
///

///

@JsonSerializable(
  explicitToJson: true,
)
class C extends $C implements A {
  final String id;
  final List<int> items;

  ///
  ///implements [$A]
  ///

  ///
  C({
    required this.id,
    required this.items,
  });
  String toString() => "(C-id:${id.toString()}|items:${items.toString()})";
  int get hashCode => hashObjects([id.hashCode, items.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          (items).equalUnorderedD(other.items);
  C copyWith_A({
    Opt<String>? id,
  }) {
    return C(
      id: id == null ? this.id as String : id.value as String,
      items: (this as C).items,
    );
  }

  C copyWith_C({
    Opt<String>? id,
    Opt<List<int>>? items,
  }) {
    return C(
      id: id == null ? this.id as String : id.value as String,
      items: items == null ? this.items as List<int> : items.value as List<int>,
    );
  }

//$A|[]|[id:String:$A]$C|[]|[id:String:null, items:List<int>:null]
//
  factory C.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "C") {
      return _$CFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the C.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$CToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'C';

    return data;
  }
}

extension $C_changeTo_E on $C {}

enum C$ { id, items }
