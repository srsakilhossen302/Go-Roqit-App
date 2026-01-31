import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

import '../../otp/view/otp_view.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;

  // Sign in controllers
  final signInEmail = TextEditingController();
  final signInPassword = TextEditingController();

  /// SIGN IN FLOW
  Future<void> signIn() async {
    if (signInEmail.text.isEmpty || signInPassword.text.isEmpty) {
      errorSnack('Please fill all fields');
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    successSnack('Signed in successfully');
    // API CALL => auth/sign-in
    Get.to(() => const OtpView(), arguments: signInEmail.text);
  }

  void errorSnack(String msg) {
    Get.snackbar(
      'Error',
      msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.bottom,
    );
  }

  void successSnack(String msg) {
    Get.snackbar(
      'Success',
      msg,
      backgroundColor: const Color(0xFF1B5E3F),
      colorText: Colors.white,
      snackPosition: SnackPosition.bottom,
    );
  }
}
