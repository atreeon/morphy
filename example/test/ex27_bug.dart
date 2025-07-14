import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex27_bug.morphy.dart';

///HASHCODE ERROR AGAIN

@Morphy()
abstract class $UserLectureInfoPopupVM {
  String get lectureId;
  bool get isExcluded;
}

@Morphy()
abstract class $UserLectureInfoPopupVM_worstWords
    implements $UserLectureInfoPopupVM {
  String get worstWordDue;
  String get stageOfStages;
}
