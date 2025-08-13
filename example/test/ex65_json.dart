import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex65_json.morphy.dart';
part 'ex65_json.g.dart';

enum EStatus { todo, complete, inProgress }

@Morphy(generateJson: true)
abstract class $TaskDependency {
  String get taskId;

  String get dependencyId;
}

@Morphy(generateJson: true)
abstract class $Task_Generic {
  String get id;

  String get name;

  String? get parentId;

  List<$TaskDependency> get dependencies;
}

