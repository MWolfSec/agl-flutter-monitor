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

const filepath = "/home/agl-driver/logs/";

final canTrafficProvider =
    ChangeNotifierProvider<MotorControllerProvider>((ref) {
  return MotorControllerProvider();
});

class MotorControllerProvider extends ChangeNotifier {
  late final KellyCanData _canData;
  late bool isLoggingActive;
  String log = "";
  MotorControllerProvider() {
    _canData = KellyCanData._(this);

    _canData.setup().then((_) {
      _canData.addListener(() => _onCanDataChanged());
    });
    isLoggingActive = false;
  }

  List<CanFrame> getFrames() {
    return _canData.getFrames();
  }

  String getFrameOutput() {
    return _canData.getFrameOutput();
  }

  String getFrameOutputLogging() {
    if (isLoggingActive) {
      return _canData.getFrameOutput();
    } else {
      return "";
    }
  }

  void toggleLogging(bool state) {
    print("toggle logging!");
    print("state " + state.toString());
    isLoggingActive = state;
    if (log == "") {
      log += "Start log!\n";
    } else {
      log += "Stop log!\n";
      print("log: " + log);
      sendLog();
      log = "";
    }
  }

  void appendToLog(String frame) {
    log += frame + "\n";
  }

  void sendLog() {
    //print(log);
    DateTime _now = DateTime.now();
    String filename = (filepath +
        'canlog-${_now.year}-${_now.month}-${_now.day}-${_now.hour}-${_now.minute}-${_now.second}.txt');
    print(filename);
    new File(filename).create().then((File file) {
      file.writeAsString(log);
    });

    print("Sent log!");
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
          //print("unable to read from can!");
        }
      } else {
        if (_failedReads > 0) {
          _failedReads = 0;
        }
        //cframes.addAll(frames);

        for (CanFrame frame in frames) {
          currentFrame = int2hexstr(frame.id ?? 0) +
              "#" +
              data2hexstr(frame.data).toUpperCase();
          if (_controller.isLoggingActive) {
            _controller.appendToLog(currentFrame);
          }
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

  String int2hexstr(int val) {
    String out = val.toRadixString(16);
    return out;
  }

  String data2hexstr(List<int> data) {
    String out = "";
    for (int element in data) {
      out += element.toRadixString(16);
    }
    return out;
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
