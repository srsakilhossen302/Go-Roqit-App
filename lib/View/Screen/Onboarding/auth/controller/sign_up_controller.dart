import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';

import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

import '../../otp/view/otp_view.dart';

class SignUpController extends GetxController {
  var isSignUp = true.obs;
  var isLoading = false.obs;

  // Sign up controllers
  final fullName = TextEditingController();
  final signUpEmail = TextEditingController();
  final signUpPassword = TextEditingController();

  void switchTab(bool value) {
    isSignUp.value = value;
  }

  /// SIGN UP FLOW
  Future<void> signUp() async {
    if (fullName.text.isEmpty ||
        signUpEmail.text.isEmpty ||
        signUpPassword.text.isEmpty) {
      errorSnack('Please fill all fields');
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    successSnack('Account created successfully');
    // API CALL => auth/sign-up
    Get.to(() => const OtpView());
  }

  void errorSnack(String msg) {
    Get.snackbar(
      'Error',
      msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void successSnack(String msg) {
    Get.snackbar(
      'Success',
      msg,
      backgroundColor: const Color(0xFF1B5E3F),
      colorText: Colors.white,
    );
  }
}
