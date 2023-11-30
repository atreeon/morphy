// ignore_for_file: UNNECESSARY_CAST

part of 'ex52_json_inheritance_generic_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class A_Generics_Sing {
  Map<List<String>, A<Object> Function(Map<String, dynamic>)> fns = {};

  factory A_Generics_Sing() => _singleton;
  static final A_Generics_Sing _singleton = A_Generics_Sing._internal();

  A_Generics_Sing._internal() {}
}

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class A<T1> extends $A<T1> {
  final T1 id;

  ///
  A({
    required this.id,
  });
  String toString() => "(A-id:${id.toString()})";
  int get hashCode => hashObjects([id.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is A && runtimeType == other.runtimeType && id == other.id;
  A copyWith_A<T1>({
    Opt<T1>? id,
  }) {
    return A(
      id: id == null ? this.id as T1 : id.value as T1,
    );
  }

//$C|[T1:null, T2:null]|[xyz:String:$C, valT1:T1:$B, valT2:T2:$B, id:T1:$A]$B|[T1:null, T2:null]|[valT1:T1:$B, valT2:T2:$B, id:T1:$A]$A|[T1:null]|[id:T1:null]
//$C|[T1:null, T2:null]|[xyz:String:$C, valT1:T1:$B, valT2:T2:$B, id:T1:$A]
//$B|[T1:null, T2:null]|[valT1:T1:$B, valT2:T2:$B, id:T1:$A]
  factory A.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "C") {
      var fn_fromJson = getFromJsonToGenericFn(
        C_Generics_Sing().fns,
        json,
        ['_T1_', '_T2_'],
      );
      return fn_fromJson(json);
    } else if (json['_className_'] == "B") {
      var fn_fromJson = getFromJsonToGenericFn(
        B_Generics_Sing().fns,
        json,
        ['_T1_', '_T2_'],
      );
      return fn_fromJson(json);
    } else if (json['_className_'] == "A") {
      var fn_fromJson = getFromJsonToGenericFn(
        A_Generics_Sing().fns,
        json,
        ['_T1_'],
      );
      return fn_fromJson(json);
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
    var fn_T1 = getGenericToJsonFn(_fns, T1);
    final Map<String, dynamic> data =
        _$AToJson(this, fn_T1 as Object? Function(T1));
    // Adding custom key-value pair
    data['_className_'] = 'A';
    data['_T1_'] = T1.toString();

    return data;
  }
}

extension $A_changeTo_E on $A {
  C changeTo_C<T1, T2>({
    required String xyz,
    required T1 valT1,
    required T2 valT2,
    Opt<T1>? id,
  }) {
    return C(
      xyz: xyz as String,
      valT1: valT1 as T1,
      valT2: valT2 as T2,
      id: id == null ? this.id as T1 : id.value as T1,
    );
  }

  B changeTo_B<T1, T2>({
    required T1 valT1,
    required T2 valT2,
    Opt<T1>? id,
  }) {
    return B(
      valT1: valT1 as T1,
      valT2: valT2 as T2,
      id: id == null ? this.id as T1 : id.value as T1,
    );
  }
}

enum A$ { id }

///
///implements [$A]
///

///
class B_Generics_Sing {
  Map<List<String>, B<Object, Object> Function(Map<String, dynamic>)> fns = {};

  factory B_Generics_Sing() => _singleton;
  static final B_Generics_Sing _singleton = B_Generics_Sing._internal();

  B_Generics_Sing._internal() {}
}

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class B<T1, T2> extends $B<T1, T2> implements A<T1> {
  final T1 id;
  final T1 valT1;
  final T2 valT2;

  ///
  ///implements [$A]
  ///

  ///
  B({
    required this.id,
    required this.valT1,
    required this.valT2,
  });
  String toString() =>
      "(B-id:${id.toString()}|valT1:${valT1.toString()}|valT2:${valT2.toString()})";
  int get hashCode =>
      hashObjects([id.hashCode, valT1.hashCode, valT2.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is B &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          valT1 == other.valT1 &&
          valT2 == other.valT2;
  B copyWith_A<T1>({
    Opt<T1>? id,
  }) {
    return B(
      id: id == null ? this.id as T1 : id.value as T1,
      valT1: (this as B).valT1,
      valT2: (this as B).valT2,
    );
  }

  B copyWith_B<T1, T2>({
    Opt<T1>? id,
    Opt<T1>? valT1,
    Opt<T2>? valT2,
  }) {
    return B(
      id: id == null ? this.id as T1 : id.value as T1,
      valT1: valT1 == null ? this.valT1 as T1 : valT1.value as T1,
      valT2: valT2 == null ? this.valT2 as T2 : valT2.value as T2,
    );
  }

//$A|[T1:null]|[id:T1:$A]$C|[T1:null, T2:null]|[xyz:String:$C, valT1:T1:$B, valT2:T2:$B, id:T1:$A]$B|[T1:null, T2:null]|[id:T1:null, valT1:T1:null, valT2:T2:null]
//$C|[T1:null, T2:null]|[xyz:String:$C, valT1:T1:$B, valT2:T2:$B, id:T1:$A]
  factory B.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "C") {
      var fn_fromJson = getFromJsonToGenericFn(
        C_Generics_Sing().fns,
        json,
        ['_T1_', '_T2_'],
      );
      return fn_fromJson(json);
    } else if (json['_className_'] == "B") {
      var fn_fromJson = getFromJsonToGenericFn(
        B_Generics_Sing().fns,
        json,
        ['_T1_', '_T2_'],
      );
      return fn_fromJson(json);
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
    var fn_T1 = getGenericToJsonFn(_fns, T1);
    var fn_T2 = getGenericToJsonFn(_fns, T2);
    final Map<String, dynamic> data = _$BToJson(
        this, fn_T1 as Object? Function(T1), fn_T2 as Object? Function(T2));
    // Adding custom key-value pair
    data['_className_'] = 'B';
    data['_T1_'] = T1.toString();
    data['_T2_'] = T2.toString();

    return data;
  }
}

extension $B_changeTo_E on $B {
  C changeTo_C<T1, T2>({
    required String xyz,
    Opt<T1>? id,
    Opt<T1>? valT1,
    Opt<T2>? valT2,
  }) {
    return C(
      xyz: xyz as String,
      id: id == null ? this.id as T1 : id.value as T1,
      valT1: valT1 == null ? this.valT1 as T1 : valT1.value as T1,
      valT2: valT2 == null ? this.valT2 as T2 : valT2.value as T2,
    );
  }
}

enum B$ { id, valT1, valT2 }

///
///implements [$B]
///

///
class C_Generics_Sing {
  Map<List<String>, C<Object, Object> Function(Map<String, dynamic>)> fns = {};

  factory C_Generics_Sing() => _singleton;
  static final C_Generics_Sing _singleton = C_Generics_Sing._internal();

  C_Generics_Sing._internal() {}
}

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class C<T1, T2> extends $C<T1, T2> implements B<T1, T2> {
  final T1 id;
  final T1 valT1;
  final T2 valT2;
  final String xyz;

  ///
  ///implements [$B]
  ///

  ///
  C({
    required this.id,
    required this.valT1,
    required this.valT2,
    required this.xyz,
  });
  String toString() =>
      "(C-id:${id.toString()}|valT1:${valT1.toString()}|valT2:${valT2.toString()}|xyz:${xyz.toString()})";
  int get hashCode =>
      hashObjects([id.hashCode, valT1.hashCode, valT2.hashCode, xyz.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          valT1 == other.valT1 &&
          valT2 == other.valT2 &&
          xyz == other.xyz;
  C copyWith_B<T1, T2>({
    Opt<T1>? id,
    Opt<T1>? valT1,
    Opt<T2>? valT2,
  }) {
    return C(
      id: id == null ? this.id as T1 : id.value as T1,
      valT1: valT1 == null ? this.valT1 as T1 : valT1.value as T1,
      valT2: valT2 == null ? this.valT2 as T2 : valT2.value as T2,
      xyz: (this as C).xyz,
    );
  }

  C copyWith_A<T1>({
    Opt<T1>? id,
  }) {
    return C(
      id: id == null ? this.id as T1 : id.value as T1,
      valT1: (this as C).valT1,
      valT2: (this as C).valT2,
      xyz: (this as C).xyz,
    );
  }

  C copyWith_C<T1, T2>({
    Opt<T1>? id,
    Opt<T1>? valT1,
    Opt<T2>? valT2,
    Opt<String>? xyz,
  }) {
    return C(
      id: id == null ? this.id as T1 : id.value as T1,
      valT1: valT1 == null ? this.valT1 as T1 : valT1.value as T1,
      valT2: valT2 == null ? this.valT2 as T2 : valT2.value as T2,
      xyz: xyz == null ? this.xyz as String : xyz.value as String,
    );
  }

//$B|[T1:null, T2:null]|[valT1:T1:$B, valT2:T2:$B, id:T1:$A]$A|[T1:null]|[id:T1:$A]$C|[T1:null, T2:null]|[id:T1:null, valT1:T1:null, valT2:T2:null, xyz:String:null]
//
  factory C.fromJson(Map<String, dynamic> json) {
    if (json['_className_'] == "C") {
      var fn_fromJson = getFromJsonToGenericFn(
        C_Generics_Sing().fns,
        json,
        ['_T1_', '_T2_'],
      );
      return fn_fromJson(json);
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
    var fn_T1 = getGenericToJsonFn(_fns, T1);
    var fn_T2 = getGenericToJsonFn(_fns, T2);
    final Map<String, dynamic> data = _$CToJson(
        this, fn_T1 as Object? Function(T1), fn_T2 as Object? Function(T2));
    // Adding custom key-value pair
    data['_className_'] = 'C';
    data['_T1_'] = T1.toString();
    data['_T2_'] = T2.toString();

    return data;
  }
}

extension $C_changeTo_E on $C {}

enum C$ { id, valT1, valT2, xyz }
