import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex66_setup.morphy.dart';

@morphy
abstract class $$Project {
  String get projectId;

  String get name;
}

@morphy
abstract class $Project_ClickUp implements $$Project {
  String get clickup_ListId;

  String get clickup_ApiKey;
}

///These are used to create specific test scenarios with hard coded test data
@morphy
abstract class $Project_ForTestOnly implements $$Project {
  String get forTests_id;
}

@morphy
abstract class $Project_Yaks implements $$Project {}
