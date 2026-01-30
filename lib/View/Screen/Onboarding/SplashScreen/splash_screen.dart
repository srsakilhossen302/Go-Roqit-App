import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../OnboardingScreen/onboardingScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.offAll(()=> const OnboardingScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F5F3E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo asset
            Image.asset(
              AppIcons.goRoqit, // Placeholder logo
              width: 100,
              height: 100,
            ),

            Text("Go Roqit ", style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xffFFFFFF),
            ),),

            Text("Swipe, Match, Work", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color(0xffFFFFFF),
            ),)

          ],
        ),
      ),
    );
  }
}