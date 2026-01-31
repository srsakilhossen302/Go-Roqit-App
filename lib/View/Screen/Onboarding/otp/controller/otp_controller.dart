import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import '../../../Im_Hiring_For_My_Salon/Business_Information/view/business_information_view.dart';
import '../../../Im_Looking_For_Work/Personal_Information/view/personal_information_view.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments.toString();
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<void> submitOtp() async {
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

        String role = await SharePrefsHelper.getString(
          SharedPreferenceValue.role,
        );

        if (role == 'user') {
          Get.to(() => const PersonalInformationView());
        } else if (role == 'hiring') {
          Get.to(() => const BusinessInformationView());
        }
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
