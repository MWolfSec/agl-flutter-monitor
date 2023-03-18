// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_monitor/provider.dart';
import 'package:numberpicker/numberpicker.dart';

import '../kuksa-server/vehicle-class.dart';
import '../kuksa-server/vehicle-provider.dart';
import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class DataText extends HookConsumerWidget {
  DataText({Key? key, required this.socket, required this.serverPath})
      : super(key: key);

  WebSocket socket;
  String serverPath;
  String returnVal = "none";

  @override
  Widget build(BuildContext context, ref) {
    vehicle vehicledata = ref.watch(vehicleProvider);
    switch (this.serverPath) {
      case "Vehicle.Speed":
        this.returnVal = vehicledata.speed.toString();
        break;
      case "Vehicle.Powertrain.CombustionEngine.Speed":
        this.returnVal = vehicledata.rpm.toString();
        break;
      case "Vehicle.Powertrain.CombustionEngine.Power":
        this.returnVal = vehicledata.power.toString();
        break;
      case "Vehicle.Powertrain.CombustionEngine.Torque":
        this.returnVal = vehicledata.torque.toString();
        break;
      case "Vehicle.Powertrain.CombustionEngine.ECT":
        this.returnVal = vehicledata.ect.toString();
        break;
      case "Vehicle.Powertrain.Transmission.CurrentGear":
        this.returnVal = vehicledata.gear.toString();
        break;
      case "Vehicle.CurrentLocation.Longitude":
        this.returnVal = vehicledata.lon.toString();
        break;
      case "Vehicle.CurrentLocation.Latitude":
        this.returnVal = vehicledata.lat.toString();
        break;
      case "Vehicle.Powertrain.FuelSystem.InstantConsumption":
        this.returnVal = vehicledata.fuelconsumption.toString();
        break;
      case "Vehicle.Powertrain.FuelSystem.Level":
        this.returnVal = vehicledata.fuellevel.toString();
        break;
      case "Vehicle.Powertrain.CombustionEngine.EOT":
        this.returnVal = vehicledata.eot.toString();
        break;
      default:
        print("$serverPath Not Available yet!");
        this.returnVal = "not found";
    }

    return Text(returnVal,
        style: TextStyle(
          fontSize: SizeConfig.fontsize * 2,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 255, 255, 255),
        ));
  }
}
