// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_monitor/Buttons/LogCanTraffic.dart';
import 'package:flutter_monitor/size.dart';

import 'widgets/data_text.dart';
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
                      Text('Vehicle Status',
                          style: TextStyle(
                            fontSize: SizeConfig.fontsize * 4,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Row(children: [
                            Text('Speed: ',
                                style: TextStyle(
                                  fontSize: SizeConfig.fontsize * 2,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            DataText(
                                socket: socket, serverPath: 'Vehicle.Speed'),
                          ]),
                          Row(children: [
                            Text('Engine RPM: ',
                                style: TextStyle(
                                  fontSize: SizeConfig.fontsize * 2,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            DataText(
                                socket: socket,
                                serverPath:
                                    'Vehicle.Powertrain.CombustionEngine.Speed'),
                          ]),
                          Row(children: [
                            Text('Current Gear: ',
                                style: TextStyle(
                                  fontSize: SizeConfig.fontsize * 2,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            DataText(
                                socket: socket,
                                serverPath:
                                    'Vehicle.Powertrain.Transmission.CurrentGear'),
                          ])
                        ]),
                        Column(
                          children: [
                            Row(children: [
                              Text('Engine Power: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.Powertrain.CombustionEngine.Power"),
                            ]),
                            Row(children: [
                              Text('Engine Torque: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.Powertrain.CombustionEngine.Torque"),
                            ]),
                            Row(children: [
                              Text('Engine Oil Temp: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.Powertrain.CombustionEngine.EOT"),
                            ]),
                          ],
                        ),
                        Column(
                          children: [
                            Row(children: [
                              Text('Fuel Level: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.Powertrain.FuelSystem.Level"),
                            ]),
                            Row(children: [
                              Text('Fuel Consumption: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.Powertrain.FuelSystem.InstantConsumption"),
                            ]),
                            Row(children: [
                              Text('Coolant Temp: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.Powertrain.CombustionEngine.ECT"),
                            ]),
                          ],
                        ),
                        Column(
                          children: [
                            Row(children: [
                              Text('Latitude: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.CurrentLocation.Latitude"),
                            ]),
                            Row(children: [
                              Text('Longitude: ',
                                  style: TextStyle(
                                    fontSize: SizeConfig.fontsize * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              DataText(
                                  socket: socket,
                                  serverPath:
                                      "Vehicle.CurrentLocation.Longitude"),
                            ]),
                          ],
                        )
                      ])),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    LogCanTraffic(socket: socket, serverPath: ''),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical,
                    ),
                  ],
                ),
              ),
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
                  flex: 1,
                  child: Row(
                    children: [
                      Column(children: [
                        Row(children: [
                          Text('BoostLevel: ',
                              style: TextStyle(
                                fontSize: SizeConfig.fontsize * 2,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                          DataText(
                              socket: socket,
                              serverPath: 'Vehicle.TurboCharger.BoostLevel'),
                        ]),
                        Row(children: [
                          Text('BoostPressure: ',
                              style: TextStyle(
                                fontSize: SizeConfig.fontsize * 2,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                          DataText(
                              socket: socket,
                              serverPath: 'Vehicle.TurboCharger.BoostPressure'),
                        ]),
                      ]),
                    ],
                  )),
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
            ],
          ),
        ));
  }
}
