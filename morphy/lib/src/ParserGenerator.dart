import 'dart:async';

import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class ParserGenerator<Annotation> extends GeneratorForAnnotation<Annotation> {
  // @override
  // FutureOr<String> generate(
  //     LibraryReader oldLibrary,
  //     BuildStep buildStep,
  //     ) async {
  //
  // }
  @override
  Stream<String> generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {}
}
