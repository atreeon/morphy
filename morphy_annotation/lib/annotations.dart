import 'package:collection/collection.dart';

/// {@macro MorphyX}
const morphy = Morphy(generateJson: false, explicitSubTypes: null);

/// ### Morphy2 will be created before Morphy, sometimes the generator needs a related class to be built before another.
/// ---
/// {@macro MorphyX}
const morphy2 = Morphy2(generateJson: false, explicitSubTypes: null);

class Morphy implements MorphyX {
  /// if we want a copyWith (cwX) method for a subtype in this same class
  final List<Type>? explicitSubTypes;

  final bool generateJson;

  final bool privateConstructor;

  /// {@template MorphyX}
  /// ### normal class; prepend class with a single dollar & make abstract
  /// ```
  /// abstract class $MyClass { ...
  /// ```
  /// ---
  /// ### define non final get properties only (no constructor)
  /// ```
  /// String get aValue;
  /// int? get nullableValue;
  /// ```
  /// ---
  /// ### to instantiate or use the class omit the dollar
  /// ```
  /// MyClass(aValue: "x");
  /// ```
  /// ---
  /// ### to implement an interface use [implements]
  /// ```
  /// @morphy
  /// abstract class $B implements $$A<int, String> {
  ///  String get z;
  /// ```
  /// ---
  /// ### ensure the generic names are the same between inherited classes
  /// ```
  /// class $A<T1> { ...
  /// class $B<T1> extends $A<T1> { ...
  /// ```
  /// ---
  /// ### abstract classes; prepend class with two dollars
  /// ```
  /// class $$myAbstractClass { ...
  /// ```
  /// ---
  /// ### private constructor for custom constructors; postpend with underscore
  /// ```
  /// abstract class $A_ {
  /// ```
  ///
  /// this then allows default values by defining custom functions in the same file
  ///
  /// ```
  /// A_ AFactory() {
  ///    return A_._(a: "my default value");
  /// }
  /// ```
  ///
  /// it makes it explict that the default constructor cannot be used
  /// ---
  /// ### constant constructors
  /// ```
  /// abstract class $A {
  ///  int get a;
  ///  const $A();
  ///  }
  ///  ```
  ///
  ///  must add a ```const $A()``` constructor to abstract class
  /// {@endtemplate}
  ///
  /// ### generics / type parameters
  /// When defining new type parameters on sibling classes ensure that the
  /// type parameter names are different.
  ///
  /// This is ok
  /// `class $A<T> {`
  /// `class $B<T, TB1> implements $A {`
  /// `class $C<T, TC1> implements $A {`
  ///
  /// This will throw an error
  /// `class $A<T> {`
  /// `class $B<T, T1> implements $A {`
  /// `class $C<T, T1> implements $A {`
  const Morphy({
    this.explicitSubTypes = null,
    this.generateJson = false,
    this.privateConstructor = false,
  });
}

class Morphy2 implements MorphyX {
  final List<Type>? explicitSubTypes;
  final bool generateJson;
  final bool privateConstructor;

  const Morphy2({
    this.explicitSubTypes = null,
    this.generateJson = false,
    this.privateConstructor = false,
  });
}

abstract class MorphyX {
  List<Type>? get explicitSubTypes;

  bool get generateJson;
}

Object? Function(Never) getGenericToJsonFn(
  Map<Type, Object? Function(Never)> fns,
  Type type,
) {
  var type1_fn = fns[type];

  if (type1_fn == null) //
    return (x) => x;

  return type1_fn;
}

dynamic getFromJsonToGenericFn(
  Map<List<String>, dynamic Function(Map<String, dynamic>)> fns,
  Map<String, dynamic> json,
  List<String> genericType,
) {
  var types = genericType.map((e) => json[e]).toList();

  var fromJsonToGeneric_fn = fns.entries.firstWhereOrNull((entry) => ListEquality().equals(entry.key, types))?.value;
  if (fromJsonToGeneric_fn == null) //
    throw Exception("From JSON function not found");
  return fromJsonToGeneric_fn;
}
