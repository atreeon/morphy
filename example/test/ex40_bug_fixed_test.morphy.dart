// ignore_for_file: UNNECESSARY_CAST

part of 'ex40_bug_fixed_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
abstract class MonitorI extends $$MonitorI {
  String get monitorId;
  int get locationId;
  String get monitorName;
  String get monitorPostcode;
  bool get isExcluded;
  MonitorI copyWith_MonitorI({
    Opt<String>? monitorId,
    Opt<int>? locationId,
    Opt<String>? monitorName,
    Opt<String>? monitorPostcode,
    Opt<bool>? isExcluded,
  });
}

extension $$MonitorI_changeTo_E on $$MonitorI {}

enum MonitorI$ {
  monitorId,
  locationId,
  monitorName,
  monitorPostcode,
  isExcluded
}

///
///implements [$$MonitorI]
///

///
class Monitor_PurpleAir extends $Monitor_PurpleAir implements MonitorI {
  final String monitorId;
  final int locationId;
  final String monitorName;
  final String monitorPostcode;
  final bool isExcluded;
  final String purpleAirSensorApiId;

  ///
  ///implements [$$MonitorI]
  ///

  ///
  Monitor_PurpleAir({
    required this.monitorId,
    required this.locationId,
    required this.monitorName,
    required this.monitorPostcode,
    required this.isExcluded,
    required this.purpleAirSensorApiId,
  });
  String toString() =>
      "(Monitor_PurpleAir-monitorId:${monitorId.toString()}|locationId:${locationId.toString()}|monitorName:${monitorName.toString()}|monitorPostcode:${monitorPostcode.toString()}|isExcluded:${isExcluded.toString()}|purpleAirSensorApiId:${purpleAirSensorApiId.toString()})";
  int get hashCode => hashObjects([
        monitorId.hashCode,
        locationId.hashCode,
        monitorName.hashCode,
        monitorPostcode.hashCode,
        isExcluded.hashCode,
        purpleAirSensorApiId.hashCode
      ]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Monitor_PurpleAir &&
          runtimeType == other.runtimeType &&
          monitorId == other.monitorId &&
          locationId == other.locationId &&
          monitorName == other.monitorName &&
          monitorPostcode == other.monitorPostcode &&
          isExcluded == other.isExcluded &&
          purpleAirSensorApiId == other.purpleAirSensorApiId;
  Monitor_PurpleAir copyWith_MonitorI({
    Opt<String>? monitorId,
    Opt<int>? locationId,
    Opt<String>? monitorName,
    Opt<String>? monitorPostcode,
    Opt<bool>? isExcluded,
  }) {
    return Monitor_PurpleAir(
      monitorId: monitorId == null
          ? this.monitorId as String
          : monitorId.value as String,
      locationId:
          locationId == null ? this.locationId as int : locationId.value as int,
      monitorName: monitorName == null
          ? this.monitorName as String
          : monitorName.value as String,
      monitorPostcode: monitorPostcode == null
          ? this.monitorPostcode as String
          : monitorPostcode.value as String,
      isExcluded: isExcluded == null
          ? this.isExcluded as bool
          : isExcluded.value as bool,
      purpleAirSensorApiId: (this as Monitor_PurpleAir).purpleAirSensorApiId,
    );
  }

  Monitor_PurpleAir copyWith_Monitor_PurpleAir({
    Opt<String>? monitorId,
    Opt<int>? locationId,
    Opt<String>? monitorName,
    Opt<String>? monitorPostcode,
    Opt<bool>? isExcluded,
    Opt<String>? purpleAirSensorApiId,
  }) {
    return Monitor_PurpleAir(
      monitorId: monitorId == null
          ? this.monitorId as String
          : monitorId.value as String,
      locationId:
          locationId == null ? this.locationId as int : locationId.value as int,
      monitorName: monitorName == null
          ? this.monitorName as String
          : monitorName.value as String,
      monitorPostcode: monitorPostcode == null
          ? this.monitorPostcode as String
          : monitorPostcode.value as String,
      isExcluded: isExcluded == null
          ? this.isExcluded as bool
          : isExcluded.value as bool,
      purpleAirSensorApiId: purpleAirSensorApiId == null
          ? this.purpleAirSensorApiId as String
          : purpleAirSensorApiId.value as String,
    );
  }
}

extension $Monitor_PurpleAir_changeTo_E on $Monitor_PurpleAir {}

enum Monitor_PurpleAir$ {
  monitorId,
  locationId,
  monitorName,
  monitorPostcode,
  isExcluded,
  purpleAirSensorApiId
}
