import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';

class ToastHelper {
  static void success(String message) {
    _showSnackBar(
      title: "Success",
      message: message,
      backgroundColor: const Color(0xFF1B5E3F),
      icon: Icons.check_circle_outline,
    );
  }

  static void error(String message) {
    _showSnackBar(
      title: "Alert",
      message: message,
      backgroundColor: const Color(0xFFC62828),
      icon: Icons.error_outline,
    );
  }

  static void warning(String message) {
    _showSnackBar(
      title: "Warning",
      message: message,
      backgroundColor: const Color(0xFFFFA000),
      icon: Icons.warning_amber_outlined,
    );
  }

  static void _showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    // Check if a snackbar is already open to prevent multiple overlapping calls
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.bottom,
      backgroundColor: backgroundColor.withOpacity(0.9), // Slightly transparent for premium feel
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: Icon(icon, color: Colors.white, size: 28.sp),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
    );
  }
}
