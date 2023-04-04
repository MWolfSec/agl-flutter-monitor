// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_monitor/kuksa-server/vehicle-provider.dart';
import 'package:flutter_monitor/kuksa-server/vehicle_methods.dart';
import '../provider.dart';

import '../size.dart';

class LogCanTraffic extends ConsumerStatefulWidget {
  WebSocket socket;
  String serverPath;
  LogCanTraffic({
    Key? key,
    required this.serverPath,
    required this.socket,
  }) : super(key: key);

  @override
  _LogState createState() => _LogState();
}

class _LogState extends ConsumerState<LogCanTraffic>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late bool isLoggingActive;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    isLoggingActive = false;
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.green)
            .animate(_controller);

    _controller.addListener(() {});

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        VISS.set(
            widget.socket, ref, widget.serverPath, isLoggingActive.toString());
      }
      if (status == AnimationStatus.dismissed) {
        VISS.set(
            widget.socket, ref, widget.serverPath, isLoggingActive.toString());
      }
    });
  }

  // dismiss the animation when widget exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isLoggingActive = ref.watch(vehicleProvider).isLoggingActive;
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return InkWell(
            child: AnimatedContainer(
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight * 0.10,
                maxWidth: SizeConfig.screenWidth * 0.15,
              ),
              decoration: BoxDecoration(
                gradient: isLoggingActive
                    ? RadialGradient(
                        colors: [Colors.black, Colors.lightBlue],
                        radius: 2,
                      )
                    : null,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockSizeVertical * 2),
              ),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                child: Container(
                  width: SizeConfig.screenWidth * 0.15,
                  height: SizeConfig.screenHeight * 0.10,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      'Log',
                      style: TextStyle(
                        color: _colorAnimation.value,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              isLoggingActive ? _controller.reverse() : _controller.forward();
              ref
                  .read(vehicleProvider.notifier)
                  .update(isLoggingActive: !isLoggingActive);
              ref.read(canTrafficProvider).toggleLogging(isLoggingActive);
            },
          );
        });
  }
}
