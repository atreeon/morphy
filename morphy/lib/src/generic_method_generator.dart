import 'common/NameType.dart';

class GenericTypeHelper {
  static bool isGenericType(NameType type) {
    return type.type?.contains('<') ?? false;
  }

  static List<String> extractTypeParams(List<NameType> typeParams) {
    return typeParams
        .map((t) => t.type?.replaceAll(RegExp(r'\$+'), '') ?? 'dynamic')
        .toList();
  }
}

class GenericMethodGenerator {
  static String generate({
    required String className,
    required List<NameType> typeParams,
    required List<NameType> fields,
    required List<NameType> interfaces,
  }) {
    final cleanTypeParams = GenericTypeHelper.extractTypeParams(typeParams);

    return '''
      $className<${cleanTypeParams.join(', ')}> copyWith$className({
        ${className}Patch? patchInput,
        ${_generateParams(fields, typeParams)}
      }) {
        final _patcher = patchInput ?? ${className}Patch();
        ${_generatePatchAssignments(fields)}
        final _patchMap = _patcher.toPatch();
        return $className<${cleanTypeParams.join(', ')}>._(
          ${_generateConstructorParams(fields, className)}
        );
      }
    ''';
  }

  static String _generateParams(
      List<NameType> fields, List<NameType> typeParams) {
    return fields.map((f) {
      var name = f.name;
      var type = f.type ?? 'dynamic';
      return '$type Function()? $name';
    }).join(',\n      ');
  }

  static String _generatePatchAssignments(List<NameType> fields) {
    return fields.map((f) {
      var name = f.name;
      var isRequired = !(f.type?.endsWith('?') ?? true);

      if (isRequired) {
        return '_patcher.with$name($name());';
      }
      return '''
      if ($name != null) {
        _patcher.with$name($name());
      }''';
    }).join('\n    ');
  }

  static String _generateConstructorParams(
      List<NameType> fields, String className) {
    return fields.map((f) {
      var name = f.name;
      return '$name: _patchMap[$className\$.$name] ?? this.$name';
    }).join(',\n        ');
  }
}
