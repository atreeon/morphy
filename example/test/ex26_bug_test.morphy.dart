// ignore_for_file: UNNECESSARY_CAST

part of 'ex26_bug_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///WEIRD HASHCODE BUG
///To recreate
///1. run pw
///2. make a change here & save
///3. make change to ex25 & save
///4. make change to ex25 & save
///5. hashCode error is shown
///
class ScheduleVM<T> extends $ScheduleVM<T> {
  final List<T> schedules;

  ///WEIRD HASHCODE BUG
  ///To recreate
  ///1. run pw
  ///2. make a change here & save
  ///3. make change to ex25 & save
  ///4. make change to ex25 & save
  ///5. hashCode error is shown
  ///
  ScheduleVM({
    required this.schedules,
  });
  String toString() => "(ScheduleVM-schedules:${schedules.toString()})";
  int get hashCode => hashObjects([schedules.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleVM &&
          runtimeType == other.runtimeType &&
          (schedules).equalUnorderedD(other.schedules);
  ScheduleVM copyWith_ScheduleVM<T>({
    Opt<List<T>>? schedules,
  }) {
    return ScheduleVM(
      schedules: schedules == null
          ? this.schedules as List<T>
          : schedules.value as List<T>,
    );
  }
}

extension $ScheduleVM_changeTo_E on $ScheduleVM {}

enum ScheduleVM$ { schedules }
