import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackbar {
  static void success({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.top,
      backgroundColor: const Color(0xFF1B5E3F),
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void error({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.top,
      backgroundColor: const Color(0xFFE11D48), // Modern Red
      colorText: Colors.white,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void info({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.top,
      backgroundColor: const Color(0xFF3B82F6), // Modern Blue
      colorText: Colors.white,
      icon: const Icon(Icons.info_outline, color: Colors.white),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
