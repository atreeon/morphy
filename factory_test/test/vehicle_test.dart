import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'vehicle_test.morphy.dart';

@Morphy(nonSealed: true)
abstract class $$Vehicle {
  String get type;
  int get wheels;
}

void main() {
  group('Vehicle Tests', () {
    test('should create Vehicle instance', () {
      var car = Vehicle(type: "car", wheels: 4);

      expect(car.type, "car");
      expect(car.wheels, 4);
    });

    test('should have copyWith methods', () {
      var car = Vehicle(type: "car", wheels: 4);
      var bike = car.copyWithVehicle(wheels: 2);

      expect(bike.type, "car");
      expect(bike.wheels, 2);
    });

    test('should have patchWith methods', () {
      var car = Vehicle(type: "car", wheels: 4);
      var patch = VehiclePatch()..withWheels(3);
      var tricycle = car.patchWithVehicle(patchInput: patch);

      expect(tricycle.type, "car");
      expect(tricycle.wheels, 3);
    });
  });
}
