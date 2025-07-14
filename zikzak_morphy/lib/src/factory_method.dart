class FactoryMethodInfo {
  final String name;
  final List<FactoryParameterInfo> parameters;
  final String bodyCode;
  final String className;

  FactoryMethodInfo({
    required this.name,
    required this.parameters,
    required this.bodyCode,
    required this.className,
  });
}

class FactoryParameterInfo {
  final String name;
  final String type;
  final bool isRequired;
  final bool isNamed;
  final bool hasDefaultValue;
  final String? defaultValue;

  FactoryParameterInfo({
    required this.name,
    required this.type,
    required this.isRequired,
    required this.isNamed,
    required this.hasDefaultValue,
    this.defaultValue,
  });
}
