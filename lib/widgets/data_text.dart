// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_monitor/provider.dart';
import 'package:numberpicker/numberpicker.dart';

import '../kuksa-server/vehicle-class.dart';
import '../kuksa-server/vehicle-provider.dart';
import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class DataText extends ConsumerWidget {
  DataText({Key? key, required this.socket, required this.serverPath})
      : super(key: key);

  WebSocket socket;
  String serverPath;
  String returnVal = "none";

  @override
  Widget build(BuildContext context, ref) {
    vehicle vehicledata = ref.watch(vehicleProvider);

    if (this.serverPath == "Vehicle.Speed") {
      this.returnVal = vehicledata.speed.toString();
    }

    return Text(returnVal,
        style: TextStyle(
          fontSize: SizeConfig.fontsize * 2,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 255, 255, 255),
        ));
  }
}
