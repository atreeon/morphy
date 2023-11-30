// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: unused_element

part of 'ex20_inheritance_generics_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class BQR extends $BQR {
  final BS<BI> batch;

  ///
  BQR({
    required this.batch,
  });
  BQR._({
    required this.batch,
  });
  String toString() => "(BQR-batch:${batch.toString()})";
  int get hashCode => hashObjects([batch.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BQR && runtimeType == other.runtimeType && batch == other.batch;
  BQR copyWith_BQR({
    Opt<BS<BI>>? batch,
  }) {
    return BQR._(
      batch: batch == null ? this.batch as BS<BI> : batch.value as BS<BI>,
    );
  }
}

extension $BQR_changeTo_E on $BQR {}

enum BQR$ { batch }

///
class BS<Tbi extends BI> extends $BS<Tbi> {
  final List<Tbi> batchItems;

  ///
  BS({
    required this.batchItems,
  });
  BS._({
    required this.batchItems,
  });
  String toString() => "(BS-batchItems:${batchItems.toString()})";
  int get hashCode => hashObjects([batchItems.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BS &&
          runtimeType == other.runtimeType &&
          (batchItems).equalUnorderedD(other.batchItems);
  BS copyWith_BS<Tbi extends BI>({
    Opt<List<Tbi>>? batchItems,
  }) {
    return BS._(
      batchItems: batchItems == null
          ? this.batchItems as List<Tbi>
          : batchItems.value as List<Tbi>,
    );
  }
}

extension $BS_changeTo_E on $BS {}

enum BS$ { batchItems }

///
///implements [$BS]
///

///
class BS_BI extends $BS_BI implements BS<BI> {
  final List<BI> batchItems;

  ///
  ///implements [$BS]
  ///

  ///
  BS_BI({
    required this.batchItems,
  });
  BS_BI._({
    required this.batchItems,
  });
  String toString() => "(BS_BI-batchItems:${batchItems.toString()})";
  int get hashCode => hashObjects([batchItems.hashCode]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BS_BI &&
          runtimeType == other.runtimeType &&
          (batchItems).equalUnorderedD(other.batchItems);
  BS_BI copyWith_BS<Tbi extends BI>({
    Opt<List<Tbi>>? batchItems,
  }) {
    return BS_BI._(
      batchItems: batchItems == null
          ? this.batchItems as List<BI>
          : batchItems.value as List<BI>,
    );
  }

  BS_BI copyWith_BS_BI({
    Opt<List<BI>>? batchItems,
  }) {
    return BS_BI._(
      batchItems: batchItems == null
          ? this.batchItems as List<BI>
          : batchItems.value as List<BI>,
    );
  }
}

extension $BS_BI_changeTo_E on $BS_BI {}

enum BS_BI$ { batchItems }
