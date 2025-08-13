import 'package:morphy_annotation/morphy_annotation.dart';

import 'ex66_setup.dart';

part 'ex66_tostring2.morphy.dart';

//just testing the morphy classes get built without any compile time error

@morphy
abstract class $$ProjectsRepoState {}

@morphy
abstract class $ProjectsRepoState_waiting implements $$ProjectsRepoState {}

@morphy
abstract class $ProjectsRepoState_error implements $$ProjectsRepoState {}

@morphy
abstract class $ProjectsRepoState_data implements $$ProjectsRepoState {
  List<$$Project> get projects;
}

