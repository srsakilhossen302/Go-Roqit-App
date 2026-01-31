import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';

import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void submitOtp() {
    if (pinController.text.length == 4) {
      // Validate
      if (pinController.text == '2222') {
        Get.snackbar(
          'Success',
          'OTP Submitted',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // API CALL => Verify OTP
      } else {
        Get.snackbar(
          'Error',
          'Pin is incorrect',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter 4 digits',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
