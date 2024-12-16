import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dartx/dartx.dart';

import 'NameType.dart';
import 'classes.dart';

/// [interfaces] a list of interfaces the class implements
///
/// [classComment] the comment of the class itself
String getClassComment(List<Interface> interfaces, String? classComment) {
  var a = interfaces
      .where((e) => e is InterfaceWithComment && e.comment != classComment) //
      .map((e) {
    var interfaceComment = e is InterfaceWithComment && e.comment != null //
        ? "\n${e.comment}"
        : "";
    return "///implements [${e.interfaceName}]\n///\n$interfaceComment\n///";
  }).toList();

  if (classComment != null) //
    a.insert(0, classComment + "\n///");

  return a.join("\n").trim() + "\n";
}

MethodDetails<TMeta1> getMethodDetailsForFunctionType<TMeta1>(
  FunctionTypedElement fn,
  TMeta1 GetMetaData(ParameterElement parameterElement),
) {
  var returnType = typeToString(fn.returnType);

  var paramsPositional2 = fn.parameters.where((x) => x.isPositional);
  var paramsNamed2 = fn.parameters.where((x) => x.isNamed);

  var paramsPositional = paramsPositional2
      .map((x) => NameTypeClassCommentData<TMeta1>(
            x.name.toString(),
            typeToString(x.type),
            null,
            comment: x.documentationComment,
            meta1: GetMetaData(x),
          ))
      .toList();
  var paramsNamed = paramsNamed2
      .map((x) => NameTypeClassCommentData<TMeta1>(
            x.name.toString(),
            typeToString(x.type),
            null,
            comment: x.documentationComment,
            meta1: GetMetaData(x),
          ))
      .toList();

  var typeParameters2 = fn.typeParameters //
      .map((e) {
    final bound = e.bound;
    return GenericsNameType(e.name, bound == null ? null : typeToString(bound));
  }).toList();

  return MethodDetails<TMeta1>(fn.documentationComment, fn.name ?? "",
      paramsPositional, paramsNamed, typeParameters2, returnType);
}

List<NameTypeClassComment> getAllFields(
    List<InterfaceType> interfaceTypes, ClassElement element) {
  var superTypeFields = interfaceTypes //
      .where((x) => x.element.name != "Object")
      .flatMap((st) => st.element.fields.map((f) => //
          NameTypeClassComment(f.name, typeToString(f.type), st.element.name,
              comment: f.getter?.documentationComment,
              isEnum: f.type.element is EnumElement)))
      .toList();

  var classFields = element.fields
      .map((f) => //
          NameTypeClassComment(f.name, typeToString(f.type), element.name,
              comment: f.getter?.documentationComment,
              isEnum: f.type.element is EnumElement))
      .toList();

  //distinct, will keep classFields over superTypeFields
  return (classFields + superTypeFields).distinctBy((x) => x.name).toList();
}

String typeToString(DartType type) {
  final alias = type.alias;
  final manual = alias != null
      ? aliasToString(alias)
      : type is FunctionType
          ? functionToString(type)
          : type is RecordType
              ? recordToString(type)
              : type is ParameterizedType
                  ? genericToString(type)
                  : null;
  final nullMarker = type.nullabilitySuffix == NullabilitySuffix.question
      ? '?'
      : type.nullabilitySuffix == NullabilitySuffix.star
          ? '*'
          : '';
  return manual != null ? "$manual$nullMarker" : type.toString();
}

String aliasToString(InstantiatedTypeAliasElement alias) =>
    "${alias.element.name}${alias.typeArguments.isEmpty ? '' : "<${alias.typeArguments.map(typeToString).join(', ')}>"}";

String functionToString(FunctionType type) {
  final generics = type.typeFormals.isNotEmpty
      ? "<${type.typeFormals.map((param) {
          final bound = param.bound;
          return "${param.name}${bound == null ? "" : " = ${typeToString(bound)}"}";
        }).join(', ')}>"
      : '';
  final normal = type.normalParameterNames
      .mapIndexed((index, name) =>
          "${typeToString(type.normalParameterTypes[index])} $name")
      .join(', ');
  final named = type.namedParameterTypes
      .mapEntries((entry) =>
          "${entry.value.element!.hasRequired ? 'required ' : ''}${typeToString(entry.value)} ${entry.key}")
      .join(', ');
  final optional = type.optionalParameterNames
      .mapIndexed((index, name) =>
          "${typeToString(type.optionalParameterTypes[index])} $name")
      .join(', ');
  return "${typeToString(type.returnType)} Function$generics(${[
    if (normal.isNotEmpty) normal,
    if (named.isNotEmpty) "{$named}",
    if (optional.isNotEmpty) "[$optional]"
  ].join(', ')})";
}

String recordToString(RecordType type) {
  final positional =
      type.positionalFields.map((e) => typeToString(e.type)).join(', ');
  final named = type.namedFields
      .map((e) => "${typeToString(e.type)} ${e.name}")
      .join(', ');
  final trailing =
      type.positionalFields.length == 1 && type.namedFields.length == 0
          ? ','
          : '';
  return "(${[
    if (positional.isNotEmpty) positional,
    if (named.isNotEmpty) "{$named}"
  ].join(', ')}$trailing)";
}

String genericToString(ParameterizedType type) {
  final arguments = type.typeArguments.isEmpty
      ? ''
      : "<${type.typeArguments.map(typeToString).join(', ')}>";
  return "${type.element!.name}$arguments";
}
