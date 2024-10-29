import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tymstamp/models/constants/theme.dart';
import 'package:tymstamp/views/designs/calendar.dart';
import 'package:tymstamp/views/designs/traveLog.dart';

import '../models/constants/bottom_nav.dart';
import '../models/constants/menu.dart';
import 'designs/timelog.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  ///---> VARIABLES

  List<String> icons = [
    "assets/icons/alarm_icon.png",
    "assets/icons/timer_icon.png",
    "assets/icons/stopwatch_icon.png",
    "assets/icons/clock_icon.png",
  ];

  Menu selectedBottonNav = bottomNavItems.first;

  final _pageController = PageController(initialPage: 0);

    ///-->  ANIMATION VARIABLES
  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
            () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.clockOutline,
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding:
            const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            decoration: BoxDecoration(
              color: CustomColors.backgroundColor2.withOpacity(0.7),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.backgroundColor2.withOpacity(0.3),
                  offset: const Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  bottomNavItems.length,
                      (index) {
                    Menu navBar = bottomNavItems[index];
                    return BtmNavItem(
                      navBar: navBar,
                      press: () {
                        _pageController.animateToPage(index, duration: const Duration(milliseconds: 2), curve: Curves.easeIn);

                        updateSelectedBtmNav(navBar);
                      },
                      selectedNav:
                      selectedBottonNav,
                      iconPath: icons[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        reverse: false,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          TimeLog(),
          Travelog(),
          Calendar(),
        ],
      ),
    );
  }
}