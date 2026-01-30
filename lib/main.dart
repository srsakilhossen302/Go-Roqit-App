import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_navigation/src/root/get_material_app.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/SplashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Go Roqit App',
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          home: const SplashScreen(),
        );
      },
    );
  }
}
