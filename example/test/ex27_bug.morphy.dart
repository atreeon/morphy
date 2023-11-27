// ignore_for_file: UNNECESSARY_CAST

part of 'ex27_bug.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///HASHCODE ERROR AGAIN
///
class UserLectureInfoPopupVM extends $UserLectureInfoPopupVM {
  final String lectureId;
  final bool isExcluded;

  ///HASHCODE ERROR AGAIN
  ///
  UserLectureInfoPopupVM({
    required this.lectureId,
    required this.isExcluded,
  });
  String toString() =>
      "(UserLectureInfoPopupVM-lectureId:${lectureId.toString()}|isExcluded:${isExcluded.toString()})";
  int get hashCode => hashObjects([lectureId.hashCode, isExcluded.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLectureInfoPopupVM &&
          runtimeType == other.runtimeType &&
          lectureId == other.lectureId &&
          isExcluded == other.isExcluded;
  UserLectureInfoPopupVM copyWith_UserLectureInfoPopupVM({
    Opt<String>? lectureId,
    Opt<bool>? isExcluded,
  }) {
    return UserLectureInfoPopupVM(
      lectureId: lectureId == null
          ? this.lectureId as String
          : lectureId.value as String,
      isExcluded: isExcluded == null
          ? this.isExcluded as bool
          : isExcluded.value as bool,
    );
  }
}

extension $UserLectureInfoPopupVM_changeTo_E on $UserLectureInfoPopupVM {}

enum UserLectureInfoPopupVM$ { lectureId, isExcluded }

///
///implements [$UserLectureInfoPopupVM]
///

///HASHCODE ERROR AGAIN
///
class UserLectureInfoPopupVM_worstWords
    extends $UserLectureInfoPopupVM_worstWords
    implements UserLectureInfoPopupVM {
  final String lectureId;
  final bool isExcluded;
  final String worstWordDue;
  final String stageOfStages;

  ///
  ///implements [$UserLectureInfoPopupVM]
  ///

  ///HASHCODE ERROR AGAIN
  ///
  UserLectureInfoPopupVM_worstWords({
    required this.lectureId,
    required this.isExcluded,
    required this.worstWordDue,
    required this.stageOfStages,
  });
  String toString() =>
      "(UserLectureInfoPopupVM_worstWords-lectureId:${lectureId.toString()}|isExcluded:${isExcluded.toString()}|worstWordDue:${worstWordDue.toString()}|stageOfStages:${stageOfStages.toString()})";
  int get hashCode => hashObjects([
        lectureId.hashCode,
        isExcluded.hashCode,
        worstWordDue.hashCode,
        stageOfStages.hashCode
      ]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLectureInfoPopupVM_worstWords &&
          runtimeType == other.runtimeType &&
          lectureId == other.lectureId &&
          isExcluded == other.isExcluded &&
          worstWordDue == other.worstWordDue &&
          stageOfStages == other.stageOfStages;
  UserLectureInfoPopupVM_worstWords copyWith_UserLectureInfoPopupVM({
    Opt<String>? lectureId,
    Opt<bool>? isExcluded,
  }) {
    return UserLectureInfoPopupVM_worstWords(
      lectureId: lectureId == null
          ? this.lectureId as String
          : lectureId.value as String,
      isExcluded: isExcluded == null
          ? this.isExcluded as bool
          : isExcluded.value as bool,
      worstWordDue: (this as UserLectureInfoPopupVM_worstWords).worstWordDue,
      stageOfStages: (this as UserLectureInfoPopupVM_worstWords).stageOfStages,
    );
  }

  UserLectureInfoPopupVM_worstWords copyWith_UserLectureInfoPopupVM_worstWords({
    Opt<String>? lectureId,
    Opt<bool>? isExcluded,
    Opt<String>? worstWordDue,
    Opt<String>? stageOfStages,
  }) {
    return UserLectureInfoPopupVM_worstWords(
      lectureId: lectureId == null
          ? this.lectureId as String
          : lectureId.value as String,
      isExcluded: isExcluded == null
          ? this.isExcluded as bool
          : isExcluded.value as bool,
      worstWordDue: worstWordDue == null
          ? this.worstWordDue as String
          : worstWordDue.value as String,
      stageOfStages: stageOfStages == null
          ? this.stageOfStages as String
          : stageOfStages.value as String,
    );
  }
}

extension $UserLectureInfoPopupVM_worstWords_changeTo_E
    on $UserLectureInfoPopupVM_worstWords {}

enum UserLectureInfoPopupVM_worstWords$ {
  lectureId,
  isExcluded,
  worstWordDue,
  stageOfStages
}
