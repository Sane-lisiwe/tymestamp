import 'package:flutter/cupertino.dart';

class Menu {
  final String title;
  final Image icon;

  Menu({required this.title, required this.icon});
}

List<Menu> bottomNavItems = [
  Menu(
    title: "Timer",
    icon: Image.asset('assets/icons/clock_icon.png'),
  ),
  Menu(
    title: "TraveLog",
    icon: Image.asset('assets/icons/stopwatch_icon.png'),
  ),
  Menu(
    title: "Calendar",
    icon: Image.asset('assets/icons/alarm_icon.png'),
  ),
  Menu(
    title: "Profile",
    icon: Image.asset('assets/icons/timer_icon.png'),
  ),
];