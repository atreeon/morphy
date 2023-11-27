// ignore_for_file: UNNECESSARY_CAST

part of 'ex25_class_build_order_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy2>
// **************************************************************************

///
class ScheduleVM_Item extends $ScheduleVM_Item {
  final String value;

  ///
  ScheduleVM_Item({
    required this.value,
  });
  String toString() => "(ScheduleVM_Item-value:${value.toString()})";
  int get hashCode => hashObjects([value.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleVM_Item &&
          runtimeType == other.runtimeType &&
          value == other.value;
  ScheduleVM_Item copyWith_ScheduleVM_Item({
    Opt<String>? value,
  }) {
    return ScheduleVM_Item(
      value: value == null ? this.value as String : value.value as String,
    );
  }
}

extension $ScheduleVM_Item_changeTo_E on $ScheduleVM_Item {}

enum ScheduleVM_Item$ { value }
