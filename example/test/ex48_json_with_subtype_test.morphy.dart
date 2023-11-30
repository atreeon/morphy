// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex48_json_with_subtype_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

/// Every subtype needs to also implement toJson & fromJson
///

@JsonSerializable(
  explicitToJson: true,
)
class A extends $A {
  final String id;
  final X x;
  final List<X> xs;

  /// Every subtype needs to also implement toJson & fromJson
  ///
  A({
    required this.id,
    required this.x,
    required this.xs,
  });
  A._({
    required this.id,
    required this.x,
    required this.xs,
  });
  String toString() =>
      "(A-id:${id.toString()}|x:${x.toString()}|xs:${xs.toString()})";
  int get hashCode => hashObjects([id.hashCode, x.hashCode, xs.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          x == other.x &&
          (xs).equalUnorderedD(other.xs);
  A copyWith_A({
    Opt<String>? id,
    Opt<X>? x,
    Opt<List<X>>? xs,
  }) {
    return A._(
      id: id == null ? this.id as String : id.value as String,
      x: x == null ? this.x as X : x.value as X,
      xs: xs == null ? this.xs as List<X> : xs.value as List<X>,
    );
  }

//$A|[]|[id:String:null, x:X:null, xs:List<$X>:null]
//
  factory A.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "A") {
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

extension $A_changeTo_E on $A {}

enum A$ { id, x, xs }

///

@JsonSerializable(
  explicitToJson: true,
)
class X extends $X {
  final List<int> items;

  ///
  X({
    required this.items,
  });
  X._({
    required this.items,
  });
  String toString() => "(X-items:${items.toString()})";
  int get hashCode => hashObjects([items.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is X &&
          runtimeType == other.runtimeType &&
          (items).equalUnorderedD(other.items);
  X copyWith_X({
    Opt<List<int>>? items,
  }) {
    return X._(
      items: items == null ? this.items as List<int> : items.value as List<int>,
    );
  }

//$X|[]|[items:List<int>:null]
//
  factory X.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "X") {
      return _$XFromJson(
        json,
      );
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the X.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2([Map<Type, Object? Function(Never)>? fns]) {
    this._fns = fns ?? {};
    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$XToJson(
      this,
    );
    // Adding custom key-value pair
    data['_className_'] = 'X';

    return data;
  }
}

extension $X_changeTo_E on $X {}

enum X$ { items }
