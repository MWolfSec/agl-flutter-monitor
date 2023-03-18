// SPDX-License-Identifier: Apache-2.0

import 'dart:ffi';

class vehicle {
  late double speed;
  late int rpm;
  late int power;
  late int torque;
  late int ect;
  late int eot;
  late double lat;
  late double lon;
  late int gear;
  late double fuelconsumption;
  late int fuellevel;
  late double boostPressure;
  late int boostLevel;

  vehicle({
    required this.speed,
    required this.rpm,
    required this.power,
    required this.torque,
    required this.ect,
    required this.eot,
    required this.lat,
    required this.lon,
    required this.gear,
    required this.fuelconsumption,
    required this.fuellevel,
    required this.boostLevel,
    required this.boostPressure,
  });

  vehicle copywith({
    double? speed,
    int? rpm,
    int? power,
    int? torque,
    int? ect,
    int? eot,
    double? lat,
    double? lon,
    int? gear,
    double? fuelconsumption,
    int? fuellevel,
    double? boostPressure,
    int? boostLevel,
  }) {
    return vehicle(
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      power: power ?? this.power,
      torque: torque ?? this.torque,
      ect: ect ?? this.ect,
      eot: eot ?? this.eot,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      gear: gear ?? this.gear,
      fuelconsumption: fuelconsumption ?? this.fuelconsumption,
      fuellevel: fuellevel ?? this.fuellevel,
      boostLevel: boostLevel ?? this.boostLevel,
      boostPressure: boostPressure ?? this.boostPressure,
    );
  }
}
