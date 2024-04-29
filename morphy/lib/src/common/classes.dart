import 'package:dartx/dartx.dart';

import 'NameType.dart';

class Interface {
  final String interfaceName;
  final List<NameType> typeParams;
  final List<NameType> fields;

  /// If true the subtype has been explicitly declared in the Morphy annotation
  final bool isExplicitSubType;

  Interface(
    this.interfaceName,
    List<String> genericExtends,
    List<String> genericName,
    this.fields, [
    this.isExplicitSubType = false,
  ])  : assert(genericExtends.length == genericName.length, "typeArgs must have same length as typeParams"),
        typeParams = genericName.mapIndexed((i, x) => NameType(x, genericExtends[i])).toList() {}

  Interface.fromGenerics(
    this.interfaceName,
    this.typeParams,
    this.fields, [
    this.isExplicitSubType = false,
  ]);

  toString() => "${this.interfaceName.toString()}|${this.typeParams.toString()}|${this.fields.toString()}";
}

class InterfaceWithComment extends Interface {
  final String? comment;

  InterfaceWithComment(
    String type,
    List<String> typeArgsTypes,
    List<String> typeParamsNames,
    List<NameType> fields, {
    this.comment,
  }) : super(type, typeArgsTypes, typeParamsNames, fields);

  toString() => "${this.interfaceName.toString()}|${this.typeParams.toString()}|${this.fields.toString()}";
}

class ClassDef {
  final bool isAbstract;
  final String name;
  final List<NameTypeClassComment> fields;
  final List<GenericsNameType> generics;
  final List<String> baseTypes;

  ClassDef(
    this.isAbstract,
    this.name,
    this.fields,
    this.generics,
    this.baseTypes,
  );
}

class GenericsNameType {
  final String name;
  final String? type;

  GenericsNameType(
    this.name,
    this.type,
  );

  toString() => "${this.name}:${this.type}";
}

class MethodDetails<TMeta1> {
  final String? methodComment;
  final String methodName;
  final List<NameTypeClassCommentData<TMeta1>> paramsPositional;
  final List<NameTypeClassCommentData<TMeta1>> paramsNamed;
  final List<GenericsNameType> generics;
  final String returnType;

  MethodDetails(
    this.methodComment,
    this.methodName,
    this.paramsPositional,
    this.paramsNamed,
    this.generics,
    this.returnType,
  );
}
