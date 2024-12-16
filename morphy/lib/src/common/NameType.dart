class NameType {
  final String name;
  final String? type;
  final bool isEnum;

  NameType(this.name, this.type, {this.isEnum = false});

  toString() => "${this.name}:${this.type}";
}

class NameTypeClass extends NameType {
  final String? className;

  NameTypeClass(String name, String? type, this.className,
      {bool isEnum = false})
      : super(name, type, isEnum: isEnum);

  toString() => "${this.name}:${this.type}:${this.className}";
  toStringNameType() => super.toString();
}

class NameTypeClassComment extends NameTypeClass {
  final String? comment;

  NameTypeClassComment(
    String name,
    String? type,
    String? _class, {
    this.comment,
    bool isEnum = false,
  }) : super(name, type, _class, isEnum: isEnum);
}

class NameTypeClassCommentData<TMeta1> extends NameTypeClassComment {
  final TMeta1? meta1;

  NameTypeClassCommentData(
    String name,
    String? type,
    String? _class, {
    this.meta1,
    String? comment,
    bool isEnum = false,
  }) : super(name, type, _class, comment: comment, isEnum: isEnum);
}
