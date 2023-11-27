// ignore_for_file: UNNECESSARY_CAST

part of 'ex51_json_inheritance_generic_from_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///

@JsonSerializable(explicitToJson: true)
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

//$B|[T:null]|[blah:T:$B, id:String:$A]$A|[]|[id:String:null]
//$B|[T:null]|[blah:T:$B, id:String:$A]
  factory A.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "B") {
      var fn_fromJson = getFromJsonToGenericFn(
        B_Generics_Sing().fns,
        json,
        ['_T_'],
      );
      return fn_fromJson(json);
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

  Map<String, dynamic> toJson_2(Map<Type, Object? Function(Never)> fns) {
    this._fns = fns;
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
  B changeTo_B<T>({
    required T blah,
    Opt<String>? id,
  }) {
    return B(
      blah: blah as T,
      id: id == null ? this.id as String : id.value as String,
    );
  }
}

enum A$ { id }

///
///implements [$A]
///

///
class B_Generics_Sing {
  Map<List<String>, B<Object> Function(Map<String, dynamic>)> fns = {};

  factory B_Generics_Sing() => _singleton;
  static final B_Generics_Sing _singleton = B_Generics_Sing._internal();

  B_Generics_Sing._internal() {}
}

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class B<T> extends $B<T> implements A {
  final String id;
  final T blah;

  ///
  ///implements [$A]
  ///

  ///
  B({
    required this.id,
    required this.blah,
  });
  String toString() => "(B-id:${id.toString()}|blah:${blah.toString()})";
  int get hashCode => hashObjects([id.hashCode, blah.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          blah == other.blah;
  B copyWith_A({
    Opt<String>? id,
  }) {
    return B(
      id: id == null ? this.id as String : id.value as String,
      blah: (this as B).blah,
    );
  }

  B copyWith_B<T>({
    Opt<String>? id,
    Opt<T>? blah,
  }) {
    return B(
      id: id == null ? this.id as String : id.value as String,
      blah: blah == null ? this.blah as T : blah.value as T,
    );
  }

//$A|[]|[id:String:$A]$B|[T:null]|[id:String:null, blah:T:null]
//
  factory B.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "B") {
      var fn_fromJson = getFromJsonToGenericFn(
        B_Generics_Sing().fns,
        json,
        ['_T_'],
      );
      return fn_fromJson(json);
    } else {
      throw UnsupportedError(
          "The _className_ '${json['_className_']}' is not supported by the B.fromJson constructor.");
    }
  }

  // ignore: unused_field
  Map<Type, Object? Function(Never)> _fns = {};

  Map<String, dynamic> toJson_2(Map<Type, Object? Function(Never)> fns) {
    this._fns = fns;
    return toJson();
  }

  Map<String, dynamic> toJson() {
    var fn_T = getGenericToJsonFn(_fns, T);
    final Map<String, dynamic> data =
        _$BToJson(this, fn_T as Object? Function(T));
    // Adding custom key-value pair
    data['_className_'] = 'B';
    data['_T_'] = T.toString();

    return data;
  }
}

extension $B_changeTo_E on $B {}

enum B$ { id, blah }

///

@JsonSerializable(explicitToJson: true)
class X extends $X {
  final String xyz;

  ///
  X({
    required this.xyz,
  });
  String toString() => "(X-xyz:${xyz.toString()})";
  int get hashCode => hashObjects([xyz.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is X && runtimeType == other.runtimeType && xyz == other.xyz;
  X copyWith_X({
    Opt<String>? xyz,
  }) {
    return X(
      xyz: xyz == null ? this.xyz as String : xyz.value as String,
    );
  }

//$X|[]|[xyz:String:null]
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

  Map<String, dynamic> toJson_2(Map<Type, Object? Function(Never)> fns) {
    this._fns = fns;
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

enum X$ { xyz }
