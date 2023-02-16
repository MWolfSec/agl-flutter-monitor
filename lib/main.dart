// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_monitor/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'kuksa-server/vehicle_config.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.mouse, PointerDeviceKind.touch};
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient client = await initializeClient();

  runApp(
    ProviderScope(
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        home: GetConfig(client: client),
      ),
    ),
  );
}
