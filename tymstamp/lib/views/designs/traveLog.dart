import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide Image;

import '../../models/constants/animatedBtn.dart';
import '../../models/constants/theme.dart';
import '../../models/core/clock.dart';
import '../../models/core/dateServices.dart';

class Travelog extends StatefulWidget{
  const Travelog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TravelogState();
  }
}

class _TravelogState extends State<Travelog>{

  ///---> INSTANCES OF THE RELEVANT CLASSES
  DateTimeService dateTimeService = DateTimeService();

  late RiveAnimationController _btnAnimatedController;

  int clickCount = 0;
  bool btnActive = false;
  bool tripEnded = false;
  bool _isTripStarted = false;
  String btnText = 'Start Trip';
  late var lunchColor = Colors.red[900];
  IconData iconData = Icons.car_rental;

  void tripToggle() {
    if (clickCount < 2) {
      setState(() {
        _isTripStarted = !_isTripStarted;
        btnActive = true;
        clickCount++;

        if(clickCount == 2){
          btnActive = false;
          tripEnded = true;
        }
      });
    }
  }

  void isTripStarted(){
    if(_isTripStarted){
      setState(() {
        iconData = CupertinoIcons.location_solid;
        btnText = 'Checkpoint';
      });
    }
    else{
      setState(() {
        iconData = Icons.car_rental;
        btnText = 'Start Trip';
      });
    }
  }

  @override
  void initState() {

    isTripStarted(); //--> CHECK ON DATABASE IF TRIP HAS BEEN STARTED

    _btnAnimatedController = OneShotAnimation(
      "active",
      autoplay: false,
    );

    super.initState();
  }

  @override
  void dispose() {
    _btnAnimatedController.dispose();
    super.dispose();
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
                        color: _isTripStarted ? Colors.greenAccent[100] : Colors.redAccent[100]?.withOpacity(0.5),
                      ),
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeIn,
                            top: 3.0,
                            left: _isTripStarted ? 60.0 : 0.0,
                            right: _isTripStarted ? 0.0 : 60.0,
                            child: InkWell(
                              onTap: tripToggle,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 1000),
                                transitionBuilder: (Widget child, Animation<double> animation){
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: _isTripStarted ? Icon(Icons.check_circle, color: Colors.green, size: 35.0, key: UniqueKey()) :
                                Icon(Icons.remove_circle_outline, color: Colors.red, size: 35.0, key: UniqueKey()),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      tripEnded
                          ? 'Trip Ended'
                          : _isTripStarted
                          ? 'Trip Started'
                          : 'Trip Not Started',
                      style: TextStyle(
                          fontSize: 8,
                          color: tripEnded
                              ? Colors.red // Change the color for 'Work Ended'
                              : _isTripStarted
                              ? CustomColors.backgroundColor2
                              : Colors.red,
                          fontFamily: 'SansSerif',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 5),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimatedController,
                      press: () {
                        _btnAnimatedController.isActive = true;

                        ///---> TO DO
                        ///--> Get current location
                        ///-->  Get time and date
                        ///-->  Send to the appropriate class
                        ///--> Save to the database
                      },
                      title: 'Checkpoint',
                      icon: Icons.touch_app,
                      btnColor: Colors.blue, // Optional if you want to pass this to modify appearance
                      iconColor: Colors.white, // Optional
                      isActive: btnActive, // Set to true or false based on your logic
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}