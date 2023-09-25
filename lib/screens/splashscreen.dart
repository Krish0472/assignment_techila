import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
          splash: Lottie.asset('asset/data4.json'),
          nextScreen: LoginPage(),
          splashTransition: SplashTransition.slideTransition,
          duration: 1500,

      ),
    );
  }
}


