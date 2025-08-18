// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:build/build.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen/source_gen.dart';

/// Normalizes generator output into a stream of non-empty [String] values.
///
/// Adapted from `package:source_gen` to avoid importing its internal APIs.
Stream<String> normalizeGeneratorOutput(dynamic output) async* {
  if (output == null) return;

  if (output is String) {
    if (output.trim().isEmpty) return;
    yield output;
    return;
  }

  if (output is Iterable) {
    for (var item in output) {
      yield* normalizeGeneratorOutput(item);
    }
    return;
  }

  if (output is Stream) {
    await for (var item in output) {
      yield* normalizeGeneratorOutput(item);
    }
    return;
  }

  if (output is Future) {
    yield* normalizeGeneratorOutput(await output);
    return;
  }

  throw InvalidGenerationSourceError(
    'Invalid value returned from generator: '
    '${output.runtimeType}',
  );
}

/// Extend this type to create a [Generator] that invokes
/// [generateForAnnotatedElement] for every element in the source file annotated
/// with [T].
///
/// When all annotated elements have been processed, the results will be
/// combined into a single output with duplicate items collapsed.
///
/// For example, this will allow code generated for all elements which are
/// annotated with `@Deprecated`:
///
/// ```dart
/// class DeprecatedGenerator extends GeneratorForAnnotation<Deprecated> {
///   @override
///   Future<String> generateForAnnotatedElement(
///       Element element,
///       ConstantReader annotation,
///       BuildStep buildStep) async {
///     // Return a string representing the code to emit.
///   }
/// }
/// ```
abstract class GeneratorForAnnotationX<T> extends Generator {
  const GeneratorForAnnotationX();

  TypeChecker get typeChecker => TypeChecker.fromRuntime(T);

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final values = Set<String>();

    var classElements = library.allElements //
        .whereType<ClassElement>()
        .toList();

    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      final generatedValue = generateForAnnotatedElement(
        annotatedElement.element,
        annotatedElement.annotation,
        buildStep,
        classElements,
      );
      await for (var value in normalizeGeneratorOutput(generatedValue)) {
        assert(value.length == value.trim().length);
        values.add(value);
      }
    }

    return values.join('\n\n');
  }

  /// Implement to return source code to generate for [element].
  ///
  /// This method is invoked based on finding elements annotated with an
  /// instance of [T]. The [annotation] is provided as a [ConstantReader].
  ///
  /// Supported return values include a single [String] or multiple [String]
  /// instances within an [Iterable] or [Stream]. It is also valid to return a
  /// [Future] of [String], [Iterable], or [Stream].
  ///
  /// Implementations should return `null` when no content is generated. Empty
  /// or whitespace-only [String] instances are also ignored.
  ///
  /// THIS IS MY OVERRIDE METHOD
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
    List<ClassElement> allClassElements,
  );
}
