// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:io';

import 'package:flutter_monitor/config.dart';
import 'package:flutter_monitor/kuksa-server/vehicle-provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_monitor/kuksa-server/vehicle_server_path.dart';

class VISS {
  static const requestId = "test-id";
  static void init(WebSocket socket, WidgetRef ref) {
    print("init called");
    authorize(socket, ref);

    subscribe(socket, ref, VSPath.vehicleSpeed);
    subscribe(socket, ref, VSPath.vehicleEngineRPM);
    subscribe(socket, ref, VSPath.vehicleCoolantTemp);
    subscribe(socket, ref, VSPath.vehicleCurrentGear);
    subscribe(socket, ref, VSPath.vehicleCurrentLatitude);
    subscribe(socket, ref, VSPath.vehicleCurrentLongitude);
    subscribe(socket, ref, VSPath.vehicleFuelConsumption);
    subscribe(socket, ref, VSPath.vehicleFuelLevel);
    subscribe(socket, ref, VSPath.vehicleOilTemp);
    subscribe(socket, ref, VSPath.vehiclePower);
    subscribe(socket, ref, VSPath.vehicleTorque);

    subscribe(socket, ref, VSPath.vehicleBoostLevel);
    subscribe(socket, ref, VSPath.vehicleBoostPressure);
    subscribe(socket, ref, VSPath.vehicleLoggingState);

    update(socket, ref);
  }

  static void update(WebSocket socket, WidgetRef ref) {
    print("update called");

    get(socket, ref, VSPath.vehicleSpeed);
    get(socket, ref, VSPath.vehicleEngineRPM);
    get(socket, ref, VSPath.vehicleCoolantTemp);
    get(socket, ref, VSPath.vehicleCurrentGear);
    get(socket, ref, VSPath.vehicleCurrentLatitude);
    get(socket, ref, VSPath.vehicleCurrentLongitude);
    get(socket, ref, VSPath.vehicleFuelConsumption);
    get(socket, ref, VSPath.vehicleFuelLevel);
    get(socket, ref, VSPath.vehicleOilTemp);
    get(socket, ref, VSPath.vehiclePower);
    get(socket, ref, VSPath.vehicleTorque);
    get(socket, ref, VSPath.vehicleBoostLevel);
    get(socket, ref, VSPath.vehicleBoostPressure);
    get(socket, ref, VSPath.vehicleLoggingState);
  }

  static void authorize(WebSocket socket, WidgetRef ref) {
    final config = ref.read(ConfigStateprovider);
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": config.kuksaAuthToken,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void get(WebSocket socket, WidgetRef ref, String path) {
    final config = ref.read(ConfigStateprovider);

    Map<String, dynamic> map = {
      "action": "get",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void set(
    WebSocket socket,
    WidgetRef ref,
    String path,
    String value,
  ) {
    final config = ref.read(ConfigStateprovider);

    Map<String, dynamic> map = {
      "action": "set",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId,
      "value": value
    };
    socket.add(jsonEncode(map));
  }

  static void subscribe(WebSocket socket, WidgetRef ref, String path) {
    final config = ref.read(ConfigStateprovider);

    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void parseData(WidgetRef ref, String data) {
    final vehicleSignal = ref.read(vehicleProvider.notifier);
    Map<String, dynamic> dataMap = jsonDecode(data);
    if (dataMap["action"] == "subscription" || dataMap["action"] == "get") {
      if (dataMap.containsKey("data")) {
        if ((dataMap["data"] as Map<String, dynamic>).containsKey("dp") &&
            (dataMap["data"] as Map<String, dynamic>).containsKey("path")) {
          String path = dataMap["data"]["path"];
          Map<String, dynamic> dp = dataMap["data"]["dp"];
          if (dp.containsKey("value")) {
            if (dp["value"] != "---") {
              //print("dp: " + path);
              //print("dp value: \"" + dp["value"].toString() + "\"");
              switch (path) {
                case VSPath.vehicleSpeed:
                  //print("update speed!");
                  vehicleSignal.update(
                      speed: double.tryParse(dp["value"].toString()) ?? 0.0);
                  break;
                case VSPath.vehicleEngineRPM:
                  //print("update rpm!");
                  vehicleSignal.update(
                      rpm: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleFuelLevel:
                  //print("update fuellevel!");
                  vehicleSignal.update(
                      fuellevel: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleCoolantTemp:
                  //print("update coolant temp!");
                  vehicleSignal.update(
                      ect: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleFuelConsumption:
                  //print("update consumption!");
                  vehicleSignal.update(
                      fuelconsumption:
                          double.tryParse(dp["value"].toString()) ?? 0.0);
                  break;
                case VSPath.vehicleOilTemp:
                  //print("update oil temp!");
                  vehicleSignal.update(
                      eot: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleCurrentGear:
                  //print("update gear!");
                  vehicleSignal.update(
                      gear: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleCurrentLatitude:
                  //print("update latitude!");
                  vehicleSignal.update(
                      lat: double.tryParse(dp["value"].toString()) ?? 0.0);
                  break;
                case VSPath.vehicleCurrentLongitude:
                  //print("update longitue!");
                  vehicleSignal.update(
                      lon: double.tryParse(dp["value"].toString()) ?? 0.0);
                  break;
                case VSPath.vehicleBoostLevel:
                  //print("update boostlevel!");
                  vehicleSignal.update(
                      boostLevel: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleBoostPressure:
                  //print("update boostpressure!");
                  vehicleSignal.update(
                      boostPressure:
                          double.tryParse(dp["value"].toString()) ?? 0.0);
                  break;
                case VSPath.vehiclePower:
                  //print("update power!");
                  vehicleSignal.update(
                      power: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleTorque:
                  //print("update torque!");
                  vehicleSignal.update(
                      torque: int.tryParse(dp["value"].toString()) ?? 0);
                  break;
                case VSPath.vehicleLoggingState:
                  if (dp["value"].toString() == "true") {
                    vehicleSignal.update(isLoggingActive: true);
                  } else {
                    vehicleSignal.update(isLoggingActive: false);
                  }
                  break;
                default:
                  print("$path Not Available yet!!");
              }
            } else {
              print("ERROR:Value not available yet! Set Value of $path");
            }
          } else {
            print("ERROR:'value': Key not found!");
          }
        } else if ((!dataMap["data"] as Map<String, dynamic>)
            .containsKey("path")) {
          print("ERROR:'path':key not found !");
        } else if ((dataMap["data"] as Map<String, dynamic>)
            .containsKey("dp")) {
          print("ERROR:'dp':key not found !");
        }
      } else if (dataMap.containsKey("error")) {
        print("ERROR: ${dataMap['error']['message']}");
      }
    }
  }
}
