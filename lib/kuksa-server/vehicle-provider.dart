// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_monitor/kuksa-server/vehicle-class.dart';

final vehicleProvider = StateNotifierProvider<VehicleSignal, vehicle>(
  (ref) => VehicleSignal(),
);

class VehicleSignal extends StateNotifier<vehicle> {
  static vehicle intial_value = vehicle(
    speed: 0.0,
    rpm: 0,
    power: 0,
    torque: 0,
    ect: 0,
    eot: 0,
    fuelconsumption: 0.0,
    fuellevel: 0,
    gear: 1,
    lat: 0.0,
    lon: 0.0,
    boostPressure: 0.0,
    boostLevel: 0,
  );
  VehicleSignal() : super(intial_value);

  void update({
    double? speed,
    int? rpm,
    int? power,
    int? torque,
    int? ect,
    int? eot,
    int? fuellevel,
    double? fuelconsumption,
    int? gear,
    double? lat,
    double? lon,
    double? boostPressure,
    int? boostLevel,
  }) {
    state = state.copywith(
      speed: speed,
      rpm: rpm,
      power: power,
      torque: torque,
      ect: ect,
      eot: eot,
      fuelconsumption: fuelconsumption,
      fuellevel: fuellevel,
      gear: gear,
      lat: lat,
      lon: lon,
      boostLevel: boostLevel,
      boostPressure: boostPressure,
    );
  }
}
