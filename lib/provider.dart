// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';

final LeftClimateTempProvider = StateNotifierProvider<LeftClimateTemp, int>(
  (ref) => LeftClimateTemp(),
);

class LeftClimateTemp extends StateNotifier<int> {
  LeftClimateTemp() : super(22);

  Future<void> update(value) async {
    state = value;
  }
}

final RightClimateTempProvider = StateNotifierProvider<RightClimateTemp, int>(
  (ref) => RightClimateTemp(),
);

class RightClimateTemp extends StateNotifier<int> {
  RightClimateTemp() : super(22);

  Future<void> update(value) async {
    state = value;
  }
}

final fanSpeedProvider =
    StateNotifierProvider<fanslider, int>((ref) => fanslider());

class fanslider extends StateNotifier<int> {
  fanslider() : super(30);
  void update(value) {
    state = value;
  }
}
