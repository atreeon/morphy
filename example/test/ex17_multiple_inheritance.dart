import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex17_multiple_inheritance.morphy.dart';

///BatchLesson does xyz
@morphy
abstract class $$Batch_Lesson {}

///Lesson Lectures does blah
///something else
@morphy
abstract class $$Lesson_Lectures implements $$Batch_Lesson {}

///StagedLesson does h
@morphy
abstract class $$Batch_Staged_Lesson implements $$Batch_Lesson {}

///This is my actual class
@morphy
abstract class $Batch_Staged_Lesson_Lectures implements $$Batch_Staged_Lesson, $$Lesson_Lectures {}
