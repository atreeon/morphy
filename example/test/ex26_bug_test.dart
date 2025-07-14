import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex26_bug_test.morphy.dart';

///WEIRD HASHCODE BUG
///To recreate
///1. run pw
///2. make a change here & save
///3. make change to ex25 & save
///4. make change to ex25 & save
///5. hashCode error is shown

@morphy
abstract class $ScheduleVM<T> {
  List<T> get schedules;
}

main() {
  test("1", () {
    var x = ScheduleVM(schedules: [1, 2, 3]);
    var y = ScheduleVM(schedules: [4, 5, 6]);
    expect(x.toString(), "(ScheduleVM-schedules:[1, 2, 3])");
    expect(y.toString(), "(ScheduleVM-schedules:[4, 5, 6])");
  });
}
