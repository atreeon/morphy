import 'package:test/test.dart';
import 'package:morphy_annotation/morphy_annotation.dart';

part 'ex25_class_build_order_test.morphy.dart';
part 'ex25_class_build_order_test.morphy2.dart';

///EXPLICITLY BUILDING ONE BEFORE ANOTHER
///$ScheduleVM_Item should build before $ScheduleVM

//Sometimes one class must be built before another becuase it is referenced.
//In order to do this we use, instead of the morphy annotation, morphy2

@morphy
abstract class $ScheduleVM<T extends ScheduleVM_Item> {
  List<T> get schedules;
}

@morphy2
abstract class $ScheduleVM_Item {
  String get value;
}

main() {
  test("1", () {
    var a = ScheduleVM(
      schedules: [ScheduleVM_Item(value: "value")],
    );

    var result = a.schedules.map((e) => getItemValue(e)).toList();

    expect(result[0], "value");
  });
}

String getItemValue(ScheduleVM_Item item) {
  return item.value;
}
