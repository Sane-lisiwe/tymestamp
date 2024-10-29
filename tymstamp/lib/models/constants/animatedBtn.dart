import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:tymstamp/models/constants/theme.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    super.key,
    required RiveAnimationController btnAnimationController,
    required this.press,
    required this.title,
    required this.icon,
    required Color btnColor,
    required Color iconColor,
    this.isActive = true, // New property to determine active state
  }) : _btnAnimationController = btnAnimationController;

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;
  final String title;
  final IconData icon;
  final bool isActive; // Active state property

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? press : null, // Conditionally allow tap
      child: SizedBox(
        height: 52,
        width: 235,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/rive/button.riv",
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: isActive ? CustomColors.backgroundColor2 : Colors.grey), // Change color if inactive
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: isActive ? CustomColors.backgroundColor2 : Colors.grey, // Change color if inactive
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
