import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tymstamp/models/core/clock.dart';
import 'package:tymstamp/models/core/dateServices.dart';

import '../../models/constants/theme.dart';

class TimeLog extends StatefulWidget {
  const TimeLog({super.key});

  @override
  State<TimeLog> createState() {
    return _TimeLogState();
  }
}

class _TimeLogState extends State<TimeLog>{

  ///---> INSTANCES OF THE RELEVANT CLASSES
  DateTimeService dateTimeService = DateTimeService();

  ///--->
  int clickCount = 0;
  bool atWork = false;
  bool workEnded = false;

  void workToggle() {
    if (clickCount < 2) {
      setState(() {
        atWork = !atWork;
        clickCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 0,
            bottom: -100,
            child: Image.asset("assets/logo/logo.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateTimeService.getTodayDate(),
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'SansSerif',
                        fontWeight: FontWeight.bold,
                        color: CustomColors.backgroundColor2
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClockView(size: MediaQuery.of(context).size.height / 4),
                    const SizedBox(height: 30),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      height: 40.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: atWork
                            ? Colors.greenAccent[100]
                            : Colors.redAccent[100]?.withOpacity(0.5),
                      ),
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeIn,
                            top: 3.0,
                            left: atWork ? 60.0 : 0.0,
                            right: atWork ? 0.0 : 60.0,
                            child: InkWell(
                              onTap: () async {
                                String location = "";

                                if (clickCount < 2) {
                                  workToggle();

                                  //LocationService locServe = LocationService();
                                  ///---->TO DO
                                  ///-->  Get current location
                                  ///--> Get current time and date
                                  ///--> Push date to the appropriate class
                                  ///--> Save to Database
                                }
                                else{
                                  ///--> You can only work once in a day error
                                }

                                ///---> FOR TESTING PURPOSES: CURRENT LOCATION AND TIME
                                Future.delayed(
                                  const Duration(seconds: 4),
                                      () {
                                    print('\n\nLocation: $location \n\n');
                                  },
                                );
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 1000),
                                transitionBuilder:
                                    (Widget child, Animation<double> animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: atWork
                                    ? Icon(Icons.check_circle,
                                    color: Colors.green, size: 35.0, key: UniqueKey())
                                    : Icon(Icons.remove_circle_outline,
                                    color: Colors.red, size: 35.0, key: UniqueKey()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      workEnded
                          ? 'Work Ended'
                          : atWork
                          ? 'Work Started'
                          : 'Work Not Started',
                      style: TextStyle(
                        fontSize: 12,
                        color: workEnded ? Colors.red : atWork ? CustomColors.backgroundColor2 : Colors.red,
                        fontFamily: 'SansSerif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}