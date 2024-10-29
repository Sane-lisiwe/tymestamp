import 'package:flutter/material.dart';
import 'package:tymstamp/views/splash.dart';

void main() {
  runApp(const Tymstamp());
}

class Tymstamp extends StatelessWidget {
  const Tymstamp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
