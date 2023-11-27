import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

part 'ex48_json_generics_test.g.dart';

/*
    .toJson here is an inherited method from A
    therefore we can't change the signature

    Also, we don't really want to change the signature because
      we want polymorphism; a.toJson will have a different signature to c.toJson

    Therefore the conversion must be built into the method not the signature


    options are to
      1. add a number of parameters to toJson
      2. add parameters to the annotation to show which subclasses we allow
          remembering we can go up but not down in the inheritance hierarchy
*/

main() {
  group("A", () {
    test("a toJson", () {
      var a = A("data");
      var json = a.toJson((value) => value);

      expect(json, {'data': 'data'});
    });

    test("a fromJson", () {
      var json = {'data': 'data'};
      var a = A<String>.fromJson(json, (json) => json as String);

      expect(a.toString(), 'data');
      expect(a.runtimeType.toString(), 'A<String>');
      expect(a.data.runtimeType, String);
    });
  });
}

@JsonSerializable(genericArgumentFactories: true)
class A<T> {
  final T data;

  A(this.data);

  @override
  String toString() {
    return this.data.toString();
  }

  factory A.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$AFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$AToJson(this, toJsonT);
}
