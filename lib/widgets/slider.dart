// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_monitor/provider.dart';

import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class SliderControl extends HookConsumerWidget {
  WebSocket socket;
  SliderControl({Key? key, required this.socket}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 2,
      width: SizeConfig.screenWidth * 0.5,
      child: Slider(
        value: ref.watch(boostLevelProvider).toDouble(),
        onChanged: (value) {
          ref.read(boostLevelProvider.notifier).update(value.toInt());
          if (value > 50) {
            value = 50;
          }
          VISS.set(socket, ref, 'Vehicle.TurboCharger.BoostLevel',
              value.toInt().toString());
        },
        min: 0,
        max: 100,
        activeColor: Colors.green,
        inactiveColor: Colors.white70,
        thumbColor: Colors.grey,
        label: 'Boost Level',
      ),
    );
  }
}
