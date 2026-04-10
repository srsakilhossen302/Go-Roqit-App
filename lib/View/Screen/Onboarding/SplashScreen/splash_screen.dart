import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../OnboardingScreen/onboardingScreen.dart';
import '../auth/view/auth_screen.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../Im_Hiring_For_My_Salon/Recruiter_Panel/view/recruiter_panel_view.dart';
import '../../Im_Looking_For_Work/Home/view/home_view.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInitialScreen();
  }

  void _checkInitialScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check Token
    String? token =
        await SharePrefsHelper.getString(SharedPreferenceValue.token);
    String? role = await SharePrefsHelper.getString(SharedPreferenceValue.role);

    if (token != null && token.isNotEmpty) {
      if (role == 'recruiter') {
        Get.offAll(() => const RecruiterPanelView());
      } else {
        Get.offAll(() => const HomeView());
      }
      return;
    }

    // Check Onboarding
    bool? isOnboardingSeen =
        await SharePrefsHelper.getBool(SharedPreferenceValue.isOnboarding);

    if (isOnboardingSeen == true) {
      Get.offAll(() => const AuthScreen());
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
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
            SvgPicture.asset(
              AppIcons.appLogo, // Placeholder logo\
              color: Colors.white,
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
