import '../common/NameType.dart';

/// Shared constants and utilities for method generators
class MethodGeneratorCommons {
  /// Primitive types that don't need patch handling
  static const List<String> PRIMITIVE_TYPES = [
    'int',
    'double',
    'num',
    'String',
    'bool',
    'DateTime',
    'Duration',
    'Uri',
    'dynamic',
    'Object',
    'List',
    'Set',
    'Map',
    'Iterable',
    'Future',
    'Stream',
  ];

  /// Get the patch type name for a given type
  static String getPatchType(String baseType) {
    return '${baseType}Patch';
  }

  /// Check if a type is a primitive type
  static bool isPrimitiveType(String type) {
    final cleanType = type.replaceAll('?', '').trim();
    return PRIMITIVE_TYPES.any(
      (primitiveType) => cleanType.startsWith(primitiveType),
    );
  }

  /// Check if a type is a function type
  static bool isFunctionType(String type) {
    return type.contains(' Function(') ||
        type.startsWith('(') ||
        type.endsWith(')');
  }

  /// Check if a type needs patch handling
  static bool needsPatchHandling(
    String baseType,
    bool isEnum,
    bool isGenericType,
    List<String> knownClasses,
  ) {
    return !isPrimitiveType(baseType) &&
        !isEnum &&
        !isGenericType &&
        !isFunctionType(baseType) &&
        knownClasses.contains(baseType);
  }

  /// Generate capitalized field name for patch methods
  static String getCapitalizedFieldName(String fieldName) {
    final name = fieldName.startsWith('_') ? fieldName.substring(1) : fieldName;
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  /// Get clean field name (without underscore prefix)
  static String getCleanFieldName(String fieldName) {
    return fieldName.startsWith('_') ? fieldName.substring(1) : fieldName;
  }
}

/// Type resolution utilities
class TypeResolver {
  /// Generate type parameters string for generics
  static String generateTypeParams(
    List<NameType> generics, {
    bool isAbstractInterface = false,
  }) {
    if (generics.isEmpty) return '';

    if (isAbstractInterface) {
      // For abstract interfaces, use the parameter names (T1, T2)
      return '<${generics.map((g) => g.name).join(', ')}>';
    } else {
      // For concrete implementations, use the concrete types (int, String)
      return '<${generics.map((g) => FieldTypeAnalyzer.cleanType(g.type)).join(', ')}>';
    }
  }

  /// Resolve generic type to concrete type
  static String resolveGenericType(
    String? type,
    List<NameType> interfaceGenerics, {
    bool isAbstractInterface = false,
  }) {
    if (type == null) return 'dynamic';

    // For abstract interfaces, keep the generic type parameters
    if (isAbstractInterface) {
      return type;
    }

    // For concrete implementations, resolve to concrete types
    for (var generic in interfaceGenerics) {
      if (type == generic.name) {
        final resolvedType = generic.type;
        if (resolvedType == null || resolvedType.isEmpty) {
          return 'dynamic';
        }
        return resolvedType;
      }
    }

    return type;
  }

  /// Check if a type is a generic type
  static bool isGenericType(String baseType, List<NameType> genericParams) {
    final genericTypeNames = genericParams
        .map((g) => FieldTypeAnalyzer.cleanType(g.type))
        .toSet();
    return genericTypeNames.contains(baseType);
  }
}

/// Name cleaning utilities
class NameCleaner {
  static bool isAbstract(String name) => name.startsWith('\$\$');

  static String clean(String name) {
    if (name.startsWith('\$\$')) return name.substring(2);
    if (name.startsWith('\$')) return name.substring(1);
    return name;
  }

  static String cleanType(String? type) {
    if (type == null || type == 'null') return 'dynamic';

    // Handle double nullability and dollar signs
    type = type
        .replaceAll('\$\$', '')
        .replaceAll('\$', '')
        .replaceAll('??', '?');

    if (type.contains('<')) {
      var match = RegExp(r'([^<]+)<(.+)>').firstMatch(type);
      if (match != null) {
        var genericType = clean(match.group(1) ?? '');
        var typeParams = match.group(2) ?? '';
        var cleanedParams = typeParams
            .split(',')
            .map((t) => cleanType(t.trim()))
            .join(', ');
        return '$genericType<$cleanedParams>';
      }
    }

    return clean(type);
  }

  static bool isRequired(NameType field) {
    if (field.type == null) {
      return false;
    }
    return !field.type!.contains('?');
  }

  static String formatParameterType(NameType field) {
    var cleanedType = cleanType(field.type);
    if (isRequired(field)) {
      return 'required $cleanedType';
    }
    return '$cleanedType?';
  }
}

/// Field type analysis utilities
class FieldTypeAnalyzer {
  static bool isRequired(NameType field) {
    if (field.type == null) {
      return false;
    }
    return !field.type!.endsWith('?');
  }

  static String cleanType(String? type) {
    if (type == null || type == 'null') return 'dynamic';

    // Remove double nullable and $ prefixes
    var cleaned = type
        .replaceAll('??', '?')
        .replaceAll(RegExp(r'\$+(?![^<]*>)'), '');

    // Handle generic types
    if (cleaned.contains('<')) {
      var match = RegExp(r'([^<]+)<(.+)>').firstMatch(cleaned);
      if (match != null) {
        var genericType = match.group(1) ?? '';
        var params = match.group(2) ?? '';
        var cleanParams = params
            .split(',')
            .map((t) => cleanType(t.trim()))
            .join(', ');
        return '$genericType<$cleanParams>';
      }
    }

    return cleaned;
  }

  static String formatParameter(NameType field) {
    var cleanedType = cleanType(field.type);
    return isRequired(field) ? 'required $cleanedType' : '$cleanedType?';
  }
}
