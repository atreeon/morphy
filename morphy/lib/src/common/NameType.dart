class NameType {
  final String name;
  final String? type;

  NameType(this.name, this.type);

  toString() => "${this.name}:${this.type}";
}

class NameTypeClass extends NameType {
  final String? className;

  NameTypeClass(String name, String? type, this.className) : super(name, type);

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
  }) : super(name, type, _class);
}

class NameTypeClassCommentData<TMeta1> extends NameTypeClassComment {
  final TMeta1? meta1;

  NameTypeClassCommentData(
    String name,
    String? type,
    String? _class, {
    this.meta1,
    String? comment,
  }) : super(name, type, _class, comment: comment);
}
