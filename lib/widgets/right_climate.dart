// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_monitor/provider.dart';
import 'package:numberpicker/numberpicker.dart';

import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class RightClimateScrollWidget extends ConsumerWidget {
  RightClimateScrollWidget({Key? key, required this.socket}) : super(key: key);

  WebSocket socket;

  @override
  Widget build(BuildContext context, ref) {
    final int _selectedTemp = ref.watch(RightClimateTempProvider);

    return SizedBox(
        width: SizeConfig.screenWidth * 0.25,
        height: SizeConfig.screenHeight * 0.30,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: NumberPicker(
                minValue: 16,
                maxValue: 33,
                itemHeight: 100,
                itemCount: 5,
                value: _selectedTemp,
                textMapper: (value) {
                  return value.toString() + '°';
                },
                onChanged: (value) {
                  ref.read(RightClimateTempProvider.notifier).update(value);
                  VISS.set(
                      socket,
                      ref,
                      'Vehicle.Cabin.HVAC.Station.Row1.Right.Temperature',
                      value.toString());
                  VISS.set(
                      socket,
                      ref,
                      'Vehicle.Cabin.HVAC.Station.Row2.Right.Temperature',
                      value.toString());
                },
                selectedTextStyle: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.fontsize * 4,
                ),
                textStyle: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.fontsize * 4,
                ))));
  }
}
