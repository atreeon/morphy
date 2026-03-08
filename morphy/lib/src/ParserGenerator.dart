import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Base class for parser-style generators that emit zero or more snippets for
/// each annotated element.
abstract class ParserGenerator<Annotation> extends GeneratorForAnnotation<Annotation> {
  // @override
  // FutureOr<String> generate(
  //     LibraryReader oldLibrary,
  //     BuildStep buildStep,
  //     ) async {
  //
  // }
  /// Generates output for an annotated [element].
  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {}
}
