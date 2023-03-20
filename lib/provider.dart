// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
