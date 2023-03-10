// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_monitor/Buttons/fresh_air.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_monitor/Buttons/AC.dart';
import 'package:flutter_monitor/Buttons/ac_on_face.dart';
import 'package:flutter_monitor/Buttons/ac_on_foot.dart';
import 'package:flutter_monitor/Buttons/defrost_recirculate.dart';
import 'package:flutter_monitor/size.dart';

import 'Buttons/auto.dart';
import 'widgets/left_climate.dart';
import 'widgets/right_climate.dart';
import 'widgets/slider.dart';

class HomePage extends StatelessWidget {
  final WebSocket socket;
  HomePage({Key? key, required this.socket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 1, 90, 97),
        body: Theme(
          data: Theme.of(context).copyWith(
            // Disable splash animations
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent,
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(height: SizeConfig.screenHeight * 0.0125),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Vehicle Monitor Demo',
                            style: TextStyle(
                              fontSize: SizeConfig.fontsize * 4,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          /*SizedBox(
                            height: SizeConfig.screenHeight / 10,
                            width: SizeConfig.screenWidth / 10,
                            child: Image.asset('images/left_climate.PNG')),
                            */
                          //LeftClimateScrollWidget(socket: socket),
                        ],
                      ),
                      /* Column(
                      children: [
                          Text(
                          'Right',
                          style: TextStyle(
                            fontSize: SizeConfig.fontsize * 4,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        SizedBox(
                            height: SizeConfig.screenHeight / 10,
                            width: SizeConfig.screenWidth / 10,
                            child: Image.asset('images/right_climate.PNG')),
                        RightClimateScrollWidget(socket: socket), 
                      ],
                    ), */
                    ],
                  )),
              Container(height: SizeConfig.screenHeight * 0.0125),
              Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('CAN Traffic',
                          style: TextStyle(
                            fontSize: SizeConfig.fontsize * 4,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ],
                  )),
              Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Text(
                          'Lorem Ipsum Dolor sit amet.\nLorem Ipsum Dolor sit amet.\nLorem Ipsum Dolor sit amet.\nLorem Ipsum Dolor sit amet.\nLorem Ipsum Dolor sit amet.\nLorem Ipsum Dolor sit amet.\n',
                          style: TextStyle(
                            fontSize: SizeConfig.fontsize * 2,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ],
                  )),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * 0.10,
                    ),
                    Text('Boost Control',
                        style: TextStyle(
                          fontSize: SizeConfig.fontsize * 4,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ],
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: SizeConfig.screenHeight * 0.20,
                          child: Image(
                              width: SizeConfig.screenWidth * 0.20,
                              height: SizeConfig.screenHeight * 0.25,
                              image: Svg('images/fan.svg'),
                              color: Colors.lightBlueAccent,
                              fit: BoxFit.fitWidth)),
                      SliderControl(
                        socket: socket,
                      ),
                    ],
                  )),
              /* Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          AC(
                              socket: socket,
                              serverPath:
                                  'Vehicle.Cabin.HVAC.IsAirConditioningActive'),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          AcOnFoot(
                            img: 'images/ac_on_foot.svg',
                            socket: socket,
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          AcOnFace(
                            img: 'images/ac_on_face.svg',
                            socket: socket,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Auto(serverPath: '', socket: socket),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal,
                          ),
                          FreshAir(
                              serverPath: '',
                              socket: socket,
                              img: 'images/wind_in.svg'),
                        ],
                      ),
                      Column(
                        children: [
                          CustomButton(
                              serverPath:
                                  'Vehicle.Cabin.HVAC.IsRecirculationActive',
                              socket: socket,
                              img: 'images/in_out.svg',
                              type: 'Recirculation'),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          CustomButton(
                              serverPath:
                                  'Vehicle.Cabin.HVAC.IsRearDefrosterActive',
                              socket: socket,
                              img: 'images/rear_ws.svg',
                              type: 'Rear_defrost'),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical,
                          ),
                          CustomButton(
                              serverPath:
                                  'Vehicle.Cabin.HVAC.IsFrontDefrosterActive',
                              socket: socket,
                              img: 'images/wind_shield.svg',
                              type: 'Front_defrost'),
                        ],
                      ),
                    ],
                  )), */
            ],
          ),
        ));
  }
}
