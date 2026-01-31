import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import '../../../Im_Hiring_For_My_Salon/Business_Information/view/business_information_view.dart';
import '../../../Im_Looking_For_Work/Personal_Information/view/personal_information_view.dart';

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

    // Check role and navigate
    String role = await SharePrefsHelper.getString(SharedPreferenceValue.role);

    if (role == 'user') {
      Get.to(() => const PersonalInformationView());
    } else if (role == 'hiring') {
      Get.to(() => const BusinessInformationView());
    } else {
      Get.snackbar(
        'Error',
        'Role not found: $role',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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
