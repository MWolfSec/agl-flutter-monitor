// SPDX-License-Identifier: Apache-2.0
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:linux_can/linux_can.dart';

final boostLevelProvider =
    StateNotifierProvider<boostslider, int>((ref) => boostslider());

class boostslider extends StateNotifier<int> {
  boostslider() : super(30);
  void update(value) {
    if (value > 50) {
      value = 50;
    }
    state = value;
  }
}

const _CAN_UPDATE_DURATION = const Duration(milliseconds: 50);
const _CAN_UPDATE_DURATION_IN_HOURES = 50 / 1000 / 60 / 60;

final canTrafficProvider =
    ChangeNotifierProvider<MotorControllerProvider>((ref) {
  return MotorControllerProvider();
});

class MotorControllerProvider extends ChangeNotifier {
  MotorControllerProvider() {
    _canData = KellyCanData._(this);

    _canData.setup().then((_) {
      _canData.addListener(() => _onCanDataChanged());
    });
  }

  late final KellyCanData _canData;

  List<CanFrame> getFrames() {
    return _canData.getFrames();
  }

  void _onCanDataChanged() async {
    notifyListeners();
  }

  void _notify() {
    notifyListeners();
  }
}

/// First Message of Kelly CAN protocol
const _CAN_MESSAGE1 = 0x8CF11E05;

// Second Message of Kelly CAN protocol
const _CAN_MESSAGE2 = 0x8CF11F05;
// const _statusOfSwitchSignalsIndex = 5;

// Update frequency: Per 50ms x2 -> Wait 2 seconds
const _FAILED_READS_LIMIT = (20 * 2) * 2;

class KellyCanData extends ChangeNotifier {
  KellyCanData._(this._controller);

  final MotorControllerProvider _controller;
  final _receivePort = ReceivePort();
  int _failedReads = 0;

  List<CanFrame> cframes = [];

  List<CanFrame> getFrames() {
    return cframes;
  }

  Future setup() async {
    print("Setting up CAN communication...");
    try {
      await Isolate.spawn(readCanFrames, _receivePort.sendPort);
      _receivePort.listen(update);
      print("Successfully setup CAN.");
    } on SocketException {
      print("Failed setting up CAN.");
    }
  }

  void update(dynamic canData) {
    List<CanFrame> frames = canData;

    try {
      final failedReading = frames.isEmpty;

      // Increases [_failedReads] for every empty frame. Resets when one read
      // was sucessful.
      if (failedReading) {
        _failedReads += 1;
        if (_failedReads >= _FAILED_READS_LIMIT) {
          throw SocketException("Unable to read from can bus.");
        }
      } else {
        if (_failedReads > 0) _failedReads = 0;
        cframes = [];
        cframes.addAll(frames);

        notifyListeners();
      }
    } on SocketException {
      //print("socket exception");
    }
  }

  void _updateFromMsg1(CanFrame frame) {
    final data = frame.data;
  }

  void _updateFromMsg2(CanFrame frame) {
    final data = frame.data;
  }

  /// Converts to bytes to one integer.
  int _convertFrom2Bytes(int msb, int lsb) {
    int res = ((msb * 256) + lsb);
    return res;
  }

  bool _inRange(int value, int range) {
    return value >= 0 && value <= range;
  }
}

const _CAN_MODUL_BITRATE = 500000;

void readCanFrames(SendPort sendPort) async {
  final can = CanDevice(bitrate: _CAN_MODUL_BITRATE);
  await can.setup();

  Timer.periodic(_CAN_UPDATE_DURATION, (_) {
    List<CanFrame> frames = [];
    try {
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
      frames.add(can.read());
    } catch (e) {
      //print("Failed reading CAN frames.");
    }
    sendPort.send(frames);
  });
}
