// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../kuksa-server/vehicle-class.dart';
import '../kuksa-server/vehicle-provider.dart';
import '../size.dart';

class ErrorMsg extends HookConsumerWidget {
  ErrorMsg({Key? key, required this.socket}) : super(key: key);

  WebSocket socket;
  String returnVal = "";

  @override
  Widget build(BuildContext context, ref) {
    vehicle vehicledata = ref.watch(vehicleProvider);
    if (vehicledata.boostLevel > 60) {
      this.returnVal = "Error: BoostLevel too high!\nErrorCode: 0xAAFF0088FF";
    }

    return Text(returnVal,
        style: TextStyle(
          fontSize: SizeConfig.fontsize * 3,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 255, 0, 0),
        ));
  }
}
