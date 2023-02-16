// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:io';

import 'package:flutter_monitor/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_monitor/kuksa-server/vehicle_server_path.dart';

class VISS {
  static const requestId = "test-id";
  static void init(WebSocket socket, WidgetRef ref) {
    authorize(socket, ref);

    subscribe(socket, ref, VSPath.vehicleInsideTemperature);
    subscribe(socket, ref, VSPath.vehicleAmbientAirTemperature);
  }

  static void update(WebSocket socket, WidgetRef ref) {
    get(socket, ref, VSPath.vehicleInsideTemperature);
    get(socket, ref, VSPath.vehicleAmbientAirTemperature);
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
}
