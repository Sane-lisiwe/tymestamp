import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tymstamp/views/home.dart';
import '../models/constants/theme.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splash>{
  
  @override
  void initState(){
    
    Future.delayed(const Duration(milliseconds: 3000), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Home())));
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: CustomColors.clockOutline,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tymstamp',
              style: TextStyle(
                fontSize: 45,
                fontFamily: 'CarterOne',
                color: CustomColors.backgroundColor2,
              ),
            ),
            Image.asset('assets/logo/logo.png', width: 250),
            Text(
              'Precision Tracking for Modern Workplaces',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'CarterOne',
                color: CustomColors.backgroundColor2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset('assets/lottie/load.json', width: 100),
            const SizedBox(height: 5),
            Text(
              'Tymstamp © 2022 - 2024',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SansSerif',
                color: CustomColors.backgroundColor2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Crafted by CYBAUG',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SansSerif',
                color: CustomColors.backgroundColor2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Image.asset('assets/logo/CYBAUG.png', width: 50),
          ],
        )
      ),
    );
  }
}