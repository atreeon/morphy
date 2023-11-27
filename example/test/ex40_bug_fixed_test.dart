import 'package:test/test.dart';
import 'package:morphy/morphy.dart';

//STRANGE ERROR WHERE CAN'T PASS SUB CLASS

part 'ex40_bug_fixed_test.morphy.dart';

@Morphy()
abstract class $$MonitorI {
  String get monitorId;
  int get locationId;
  String get monitorName;
  String get monitorPostcode;
  bool get isExcluded;
}

@Morphy()
abstract class $Monitor_PurpleAir implements $$MonitorI {
  String get purpleAirSensorApiId;
}

String getUrl(MonitorI monitor) {
  return "sdf";
}

var monitor = Monitor_PurpleAir(
  monitorId: "1",
  locationId: 1,
  monitorName: "BN1",
  monitorPostcode: "BN1 4NH",
  isExcluded: false,
  purpleAirSensorApiId: "87065",
);

//why is monitor not allowed to be passed?

void main() {
  test("0 ", () {
    var result = getUrl(monitor);

    var expected = "sdf";
    expect(result, expected);
  });
}
