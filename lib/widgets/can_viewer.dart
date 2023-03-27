// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linux_can/linux_can.dart';
import '../provider.dart';
import '../size.dart';

class CanViewer extends HookConsumerWidget {
  CanViewer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    String output = "";
    List<CanFrame> messages = ref.watch(canTrafficProvider).getFrames();
    messages.forEach((element) {
      output += (element.id.toString() + "#" + element.data.toString() + "\n");
    });
    return Text(
      output,
      style: TextStyle(
        fontSize: SizeConfig.fontsize * 2,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
