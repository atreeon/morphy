// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

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

  /// Returns the [TypeChecker] used to find annotated elements.
  TypeChecker get typeChecker => TypeChecker.typeNamed(T);

  /// Scans annotated elements, normalizes generator output, and deduplicates
  /// emitted code fragments.
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final values = Set<String>();

    final classElements = library
        .allElements //
        .whereType<ClassElement>()
        .toList();

    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      final generatedValue = generateForAnnotatedElement(annotatedElement.element, annotatedElement.annotation, buildStep, classElements);
      await for (var value in _normalizeGeneratorOutput(generatedValue)) {
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
  /// Implement in subclasses to generate source for each annotated [element].
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep, List<ClassElement> allClassElements);
}

/// Converts accepted generator output shapes (`null`, `String`, `Iterable`,
/// `Stream`, or nested `Future`s of those) into a stream of trimmed strings.
Stream<String> _normalizeGeneratorOutput(Object? value) async* {
  if (value == null) {
    return;
  }

  if (value is Future) {
    yield* _normalizeGeneratorOutput(await value);
    return;
  }

  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty) {
      yield trimmed;
    }
    return;
  }

  if (value is Iterable<Object?>) {
    for (final item in value) {
      yield* _normalizeGeneratorOutput(item);
    }
    return;
  }

  if (value is Stream<Object?>) {
    await for (final item in value) {
      yield* _normalizeGeneratorOutput(item);
    }
    return;
  }

  throw _normalizeGeneratorValueError(value);
}

/// Creates a descriptive [ArgumentError] for invalid generator output values.
ArgumentError _normalizeGeneratorValueError(Object value) => ArgumentError(
  'Must be a String or be an Iterable/Stream containing String values. '
  'Found `${Error.safeToString(value)}` (${value.runtimeType}).',
);
