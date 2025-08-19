import 'package:analyzer/dart/element/element2.dart';
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
        var interfaceComment =
            e is InterfaceWithComment &&
                e.comment !=
                    null //
            ? "\n${e.comment}"
            : "";
        return "///implements [${e.interfaceName}]\n///\n$interfaceComment\n///";
      })
      .toList();

  if (classComment != null) //
    a.insert(0, classComment + "\n///");

  return a.join("\n").trim() + "\n";
}

// MethodDetails<TMeta1> getMethodDetailsForFunctionType<TMeta1>(
//   FunctionTypedElement fn,
//   TMeta1 GetMetaData(ParameterElement parameterElement),
// ) {
//   var returnType = fn.returnType.toString();
//
//   var paramsPositional2 = fn.parameters.where((x) => x.isPositional);
//   var paramsNamed2 = fn.parameters.where((x) => x.isNamed);
//
//   var paramsPositional = paramsPositional2
//       .map((x) => NameTypeClassCommentData<TMeta1>(
//             x.name.toString(),
//             x.type.toString(),
//             null,
//             comment: x.documentationComment,
//             meta1: GetMetaData(x),
//           ))
//       .toList();
//   var paramsNamed = paramsNamed2
//       .map((x) => NameTypeClassCommentData<TMeta1>(
//             x.name.toString(),
//             x.type.toString(),
//             null,
//             comment: x.documentationComment,
//             meta1: GetMetaData(x),
//           ))
//       .toList();
//
//   var typeParameters2 = fn.typeParameters //
//       .map((e) => GenericsNameType(e.name, e.bound == null ? null : e.bound.toString()))
//       .toList();
//
//   return MethodDetails<TMeta1>(fn.documentationComment, fn.name ?? "", paramsPositional, paramsNamed, typeParameters2, returnType);
// }

List<NameTypeClassComment> getAllFields(List<InterfaceType> interfaceTypes, InterfaceElement2 element) {
  var superTypeFields =
      interfaceTypes //
          .where((x) => x.element3.name3 != "Object")
          .flatMap(
            (st) => st.element3.fields2.map(
              (f) => //
                  NameTypeClassComment(f.name3!, f.type.toString(), st.element3.name3, comment: f.getter2?.documentationComment),
            ),
          )
          .toList();

  //  if(element is ClassElement){
  //    fields.addAll(element.fields.map((f) => //
  //    NameTypeClassComment(f.name, f.type.toString(), element.name, comment: f.getter?.documentationComment)).toList());
  //  } else if(element is InterfaceType){
  //    fields.addAll(element.fields.map((f) => //
  //    NameTypeClassComment(f.name, f.type.toString(), element.name, comment: f.getter?.documentationComment)).toList());
  //  }

  var classFields = element.fields2
      .map(
        (f) => //
            NameTypeClassComment(f.name3!, f.type.toString(), element.name3, comment: f.getter2?.documentationComment),
      )
      .toList();

  //distinct, will keep classFields over superTypeFields
  return (classFields + superTypeFields).distinctBy((x) => x.name).toList();
}
