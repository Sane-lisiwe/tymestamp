import 'package:flutter/material.dart';
import 'animatedBar.dart';
import 'menu.dart';

class BtmNavItem extends StatelessWidget {
  const BtmNavItem(
      {super.key,
        required this.navBar,
        required this.press,
        required this.selectedNav,
        required this.iconPath
      });

  final Menu navBar;
  final VoidCallback press;
  final Menu selectedNav;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          const SizedBox(height: 2),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: Image.asset(iconPath),
            ),
          ),
        ],
      ),
    );
  }
}