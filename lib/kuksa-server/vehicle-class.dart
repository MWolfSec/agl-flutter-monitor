// SPDX-License-Identifier: Apache-2.0

import 'dart:ffi';

class vehicle {
  late bool isAcActive;
  late bool isFrontDefrosterActive;
  late bool isRearDefrosterActive;
  late bool isAcDirectionUp;
  late bool isAcDirectionDown;
  late bool isAcDirectionMiddle;
  late bool isRecirculationActive;
  late bool isAutoActive;
  late bool isFreshAirCirculateActive;

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

  vehicle({
    required this.isAcActive,
    required this.isAcDirectionDown,
    required this.isAcDirectionMiddle,
    required this.isAcDirectionUp,
    required this.isFrontDefrosterActive,
    required this.isRearDefrosterActive,
    required this.isRecirculationActive,
    required this.isAutoActive,
    required this.isFreshAirCirculateActive,
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
  });

  vehicle copywith({
    bool? isAcActive,
    bool? isAcDirectionDown,
    bool? isAcDirectionMiddle,
    bool? isAcDirectionUp,
    bool? isFrontDefrosterActive,
    bool? isRearDefrosterActive,
    bool? isRecirculationActive,
    bool? isAutoActive,
    bool? isFreshAirCirculateActive,
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
  }) {
    return vehicle(
      isAcActive: isAcActive ?? this.isAcActive,
      isAcDirectionDown: isAcDirectionDown ?? this.isAcDirectionDown,
      isAcDirectionMiddle: isAcDirectionMiddle ?? this.isAcDirectionMiddle,
      isAcDirectionUp: isAcDirectionUp ?? this.isAcDirectionUp,
      isFrontDefrosterActive:
          isFrontDefrosterActive ?? this.isFrontDefrosterActive,
      isRearDefrosterActive:
          isRearDefrosterActive ?? this.isRearDefrosterActive,
      isRecirculationActive:
          isRecirculationActive ?? this.isRecirculationActive,
      isAutoActive: isAutoActive ?? this.isAutoActive,
      isFreshAirCirculateActive:
          isFreshAirCirculateActive ?? this.isFreshAirCirculateActive,
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
    );
  }
}
