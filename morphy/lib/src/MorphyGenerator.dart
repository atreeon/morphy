import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

////import 'package:analyzer_models/analyzer_models.dart';
import 'package:build/build.dart';
import 'package:dartx/dartx.dart';
import 'package:morphy/src/common/GeneratorForAnnotationX.dart';
import 'package:morphy/src/common/NameType.dart';
import 'package:morphy/src/common/classes.dart';
import 'package:morphy/src/common/helpers.dart';
import 'package:morphy/src/common/trees.dart';
import 'package:morphy/src/createMorphy.dart';
import 'package:morphy/src/helpers.dart';
import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:source_gen/source_gen.dart';

//List<NameTypeClassComment> getAllFields(List<InterfaceType> interfaceTypes, ClassElement element) {
//  var superTypeFields = interfaceTypes //
//      .where((x) => x.element.name != "Object")
//      .flatMap((st) => st.element.fields.map((f) => //
//          NameTypeClassComment(f.name, f.type.toString(), st.element.name, comment: f.getter.documentationComment)))
//      .toList();
//  var classFields = element.fields.map((f) => //
//      NameTypeClassComment(f.name, f.type.toString(), element.name, comment: f.getter.documentationComment)).toList();
//
//  //distinct, will keep classFields over superTypeFields
//  return (classFields + superTypeFields).distinctBy((x) => x.name).toList();
//}

/// Generates `.morphy.dart` and `.morphy2.dart` bodies for classes annotated
/// with Morphy annotations.
class MorphyGenerator<TValueT extends MorphyX> extends GeneratorForAnnotationX<TValueT> {
  /// Generates source for a single annotated class definition.
  @override
  FutureOr<String> generateForAnnotatedElement(Element ce, ConstantReader annotation, BuildStep buildStep, List<ClassElement> allClasses) {
    final sb = StringBuffer();

    //    sb.writeln("//RULES: you must use implements, not extends");

    if (ce is! ClassElement) {
      throw Exception("not a class");
    }

    final hasConstConstructor = ce.constructors.any((e) => e.isConst);

    if (ce.supertype?.element.name != "Object") {
      throw Exception("you must use implements, not extends");
    }

    final docComment = ce.documentationComment;

    final isAbstract = ce.name!.startsWith("\$\$");
    final allFields = getAllFields(ce.allSupertypes, ce).where((x) => x.name != "hashCode").toList();

    final className = ce.name!;
    var interfaces = ce.interfaces
        .map(
          (interfaceType) {
            final interfaceElement = interfaceType.element;
            return //
          InterfaceWithComment(
            interfaceElement.name!, //
            interfaceType.typeArguments.map((e) => e.toString()).toList(),
            interfaceElement.typeParameters.map((x) => x.name!).toList(),
            interfaceElement.fields.map((e) => NameType(e.name!, e.type.toString())).toList(),
            comment: interfaceElement.documentationComment,
          );
          },
        ) //
        .toList();

    //    interfaces.forEach((element) {
    //      sb.writeln("//interfacefields: ${element.fields.toString()})");
    //    });

    var classGenerics = ce.typeParameters
        .map((e) => NameTypeClassComment(e.name!, e.bound == null ? null : e.bound.toString(), null)) //
        .toList();

    final allFieldsDistinct = getDistinctFields(allFields, interfaces);

    //if I want to create a copywith from an annotation passed in I could use this
    var typesExplicit = <Interface>[];
    if (!annotation.read('explicitSubTypes').isNull) {
      typesExplicit = annotation
          .read('explicitSubTypes') //
          .listValue
          .map((explicitSubtypeValue) {
            final explicitSubtypeType = explicitSubtypeValue.toTypeValue();
            if (explicitSubtypeType?.element is! InterfaceElement) {
              throw Exception("each type for the copywith def must all be classes");
            }

            final explicitSubtypeElement = explicitSubtypeType!.element as InterfaceElement;

            return Interface.fromGenerics(
              explicitSubtypeElement.name!, // or .name
              explicitSubtypeElement.typeParameters.map((TypeParameterElement x) => NameType(x.name!, x.bound?.getDisplayString())).toList(),
              getAllFields(explicitSubtypeElement.allSupertypes, explicitSubtypeElement).where((x) => x.name != 'hashCode').toList(),
              true,
            );
          })
          .toList();
    }

    //all ValueT interfaces of the class, not just those specified in the implements list
    //  we need the ones that are inherited by the implements list
    final allValueTInterfaces =
        // Walk implemented interfaces (and their interfaces)
        flatten<InterfaceType>(ce.interfaces, (x) => x.interfaces)
            // Only keep real classes; avoids casts on mixins/extension types.
            .where((t) => t.element is ClassElement)
            .map((t) {
              final cls = t.element as ClassElement; // also a TypeParameterizedElement
              final tparams = cls.typeParameters;

              return Interface.fromGenerics(
                cls.name!, // class name
                tparams.map((TypeParameterElement p) => NameType(p.name!, p.bound?.getDisplayString())).toList(),
                getAllFields(cls.allSupertypes, cls).where((x) => x.name != 'hashCode').toList(),
              );
            })
            .union(typesExplicit)
            .distinctBy((e) => e.interfaceName)
            .toList();
    ;

    sb.writeln(createMorphy(isAbstract, allFieldsDistinct, className, docComment ?? "", interfaces, allValueTInterfaces, classGenerics, hasConstConstructor, annotation.read('generateJson').boolValue, annotation.read('hidePublicConstructor').boolValue, typesExplicit, annotation.read('nonSealed').boolValue));

    //    sb.writeln(createCopyWith(classDef, otherClasses2).replaceAll("\$", ""));

    // var isOutputCommented = false;
    //
    // var output = isOutputCommented //
    //     ? sb.toString().replaceAll("\n", "\n//")
    //     : sb.toString();

    // return output;

    return sb.toString();
  }
}
