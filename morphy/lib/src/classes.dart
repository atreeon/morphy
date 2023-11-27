////import 'package:analyzer_models/analyzer_models.dart';
//
//class NameTypeClassComment extends NameType {
//  final String comment;
//
//  NameTypeClassComment(
//    String name,
//    String type, {
//    this.comment,
//  }) : super(name, type);
//}
//
//class NameTypeClassComment extends NameTypeClass {
//  final String comment;
//
//  NameTypeClassComment(
//    String name,
//    String type, {
//    this.comment,
//  }) : super(name, type);
//}
//
//class InterfaceWithComment extends Interface {
//  final String comment;
//
//  InterfaceWithComment(
//    String type,
//    List<String> typeArgsTypes,
//    List<String> typeParamsNames, {
//    this.comment,
//  }) : super(type, typeArgsTypes, typeParamsNames);
//}
//
////class NameTypeClass {
////  final String type;
////  final String name;
////  final String className;
////
////  NameTypeClass(this.name, String type, String className) //
////      : type = type == null ? null : type.replaceAll("\$", ""),
////        className = className == null ? null : className.replaceAll("\$", "");
////
////  toString() => "${this.name}:${this.type}:${this.className}";
////}
////
////class NameType {
////  final String type;
////  final String name;
////
////  NameType(this.name, String type) //
////      : type = type == null ? null : type.replaceAll("\$", "");
////
////  toString() => "${this.name}:${this.type}";
////}
////
////class ClassDef {
////  final bool isAbstract;
////  final String name;
////  final List<NameType> fields;
////  final List<GenericType> generics;
////
////  ClassDef(this.isAbstract, this.name, this.fields, this.generics);
////}
////
////class GenericType {
////  final String name;
////  final String baseType;
////
////  GenericType(this.name, this.baseType);
////}
////
//////
////class Interface {
////  final String type;
////  final List<String> typeArgs;
////  final List<String> typeParams;
////
////  Interface(String type, List<String> typeArgs, this.typeParams)
////      : type = type.replaceAll("\$", ""),
////        typeArgs = typeArgs.map((e) => e.toString().replaceAll("\$", "")).toList() {
////    assert(this.typeArgs.length == this.typeParams.length, "typeArgs must have same length as typeParams");
////  }
////
////  toString() => "${this.type}|${this.typeArgs}|${this.typeParams}";
////}
////
////class Interface2 {
////  final String type;
////  final List<NameType> paramNameType;
////
////  Interface2(this.type, this.paramNameType);
////
////  toString() => "${this.type}|${this.paramNameType}";
////}
//
///*
//
/////For properties on a class
//class ClassType {
//  final String name;
//  final List<NameType> fields;
//  final List<GenericType> generics;
//
//  ClassType(this.name, this.fields, this.generics);
//}
//
////Our definition of a class
//class ClassOurDefinition implements ClassType {
//  final bool isAbstract;
//  final String name;
//  final List<NameType> fields;
//  final List<GenericType> generics;
//  final List<Interface> interfaces;
//
//  ClassOurDefinition(this.isAbstract, this.name, this.fields, this.generics, this.interfaces);
//}
//
//class Interface implements ClassType {
//  final String name;
//  final List<NameType> fields;
//  final List<GenericType> generics;
//  final List<Interface> interfaces;
//
//  Interface(this.name, this.fields, this.generics, this.interfaces);
//}
//
//
//
//
//
// */
////
////class ClassDefWithGenericTypes extends ClassDef {
////  final List<GenericType> generics;
////
////  ClassDefWithGenericTypes({
////    @required this.generics,
////    @required bool isAbstract,
////    @required String name,
////    @required List<NameType> fields,
////  }) : super(isAbstract, name, fields);
////}
////
