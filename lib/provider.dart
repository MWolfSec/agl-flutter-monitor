// SPDX-License-Identifier: Apache-2.0
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

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

  String getFrameOutput() {
    return _canData.getFrameOutput();
  }

  void _onCanDataChanged() async {
    notifyListeners();
  }

  void _notify() {
    notifyListeners();
  }
}

// Update frequency: Per 50ms x2 -> Wait 2 seconds
const _FAILED_READS_LIMIT = (20 * 2) * 2;

class KellyCanData extends ChangeNotifier {
  KellyCanData._(this._controller);

  final MotorControllerProvider _controller;
  final _receivePort = ReceivePort();
  int _failedReads = 0;

  Map<int, CanFrame> cframes = new Map();
  Map<int, String> output = new Map();

  List<CanFrame> getFrames() {
    return cframes.values.toList();
  }

  String getFrameOutput() {
    String out = "";
    for (var item in output.values) {
      out += item.toString() + "\n";
    }
    return out;
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
    String currentFrame = "";
    try {
      final failedReading = frames.isEmpty;

      // Increases [_failedReads] for every empty frame. Resets when one read
      // was sucessful.
      if (failedReading) {
        _failedReads += 1;
        if (_failedReads >= _FAILED_READS_LIMIT) {
          //throw SocketException("Unable to read from can bus.");
          print("unable to read from can!");
        }
      } else {
        if (_failedReads > 0) {
          _failedReads = 0;
        }
        //cframes.addAll(frames);

        for (CanFrame frame in frames) {
          currentFrame = frame.id.toString() + "#" + frame.data.toString();
          //print("frame: " + currentFrame);
          if (cframes.keys.contains(frame.id)) {
            //print("frame id already in list!");
            cframes[frame.id ?? 0] = frame;
            output[frame.id ?? 0] = currentFrame;
            //print("updated frame value!");
          } else {
            if (cframes.keys.length < 21) {
              //print("added frame to list");
              cframes.addEntries({MapEntry(frame.id ?? 0, frame)});
              output.addEntries({MapEntry(frame.id ?? 0, currentFrame)});
            } else {
              cframes.remove((cframes.keys.first));
              cframes.addEntries({MapEntry(frame.id ?? 0, frame)});
              output.remove(currentFrame);
              output.addEntries({MapEntry(frame.id ?? 0, currentFrame)});
              //print("frame exchange!");
            }
          }
        }

        notifyListeners();
      }
    } on SocketException {
      //print("socket exception");
    }
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
    } catch (e) {
      //print("Failed reading CAN frames.");
    }
    sendPort.send(frames);
  });
}
