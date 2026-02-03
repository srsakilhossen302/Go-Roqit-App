import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/auth_screen.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';

class ProfileController extends GetxController {
  var isOpenToWork = true.obs;

  void toggleOpenToWork(bool value) {
    isOpenToWork.value = value;
    // Call API to update status if needed
  }

  void logout() {
    Get.defaultDialog(
      title: "Log Out",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: "Are you sure you want to log out?",
      middleTextStyle: const TextStyle(fontSize: 14),
      backgroundColor: Colors.white,
      radius: 12,
      textCancel: "Cancel",
      textConfirm: "Log Out",
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF1B5E3F),
      onCancel: () {
        Get.back();
      },
      onConfirm: () async {
        // await SharePrefsHelper.remove(SharedPreferenceValue.token);
        // await SharePrefsHelper.remove(SharedPreferenceValue.role);
        Get.offAll(() => const AuthScreen());
      },
    );
  }
}
