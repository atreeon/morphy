// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex25_class_build_order_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///EXPLICITLY BUILDING ONE BEFORE ANOTHER
///$ScheduleVM_Item should build before $ScheduleVM
///
class ScheduleVM<T extends ScheduleVM_Item> extends $ScheduleVM<T> {
  final List<T> schedules;

  ///EXPLICITLY BUILDING ONE BEFORE ANOTHER
  ///$ScheduleVM_Item should build before $ScheduleVM
  ///
  ScheduleVM({
    required this.schedules,
  });
  ScheduleVM._({
    required this.schedules,
  });
  String toString() => "(ScheduleVM-schedules:${schedules.toString()})";
  int get hashCode => hashObjects([schedules.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleVM &&
          runtimeType == other.runtimeType &&
          (schedules).equalUnorderedD(other.schedules);
  ScheduleVM copyWith_ScheduleVM<T extends ScheduleVM_Item>({
    Opt<List<T>>? schedules,
  }) {
    return ScheduleVM._(
      schedules: schedules == null
          ? this.schedules as List<T>
          : schedules.value as List<T>,
    );
  }
}

extension $ScheduleVM_changeTo_E on $ScheduleVM {}

enum ScheduleVM$ { schedules }
