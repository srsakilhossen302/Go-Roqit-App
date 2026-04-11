import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../../Im_Hiring_For_My_Salon/Business_Information/Business_basics/view/business_information_view.dart';
import '../../../Im_Hiring_For_My_Salon/Recruiter_Panel/view/recruiter_panel_view.dart';
import '../../../Im_Looking_For_Work/Home/view/home_view.dart';
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

    Map<String, dynamic> body = {
      "email": signInEmail.text,
      "password": signInPassword.text,
    };

    try {
      final response = await Get.find<ApiClient>().postData(
        ApiUrl.signIn,
        body,
      );
      print("Sign In Status Code: ${response.statusCode}");
      print("Sign In Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        successSnack('Signed in successfully');

        // Extract data
        final data = response.body['data'];
        if (data != null) {
          String? accessToken = data['accessToken'];
          String? refreshToken = data['refreshToken'];
          String? role = data['role'];

          if (accessToken != null) {
            await SharePrefsHelper.setString(
              SharedPreferenceValue.token,
              accessToken,
            );
          }
          if (refreshToken != null) {
            await SharePrefsHelper.setString(
              SharedPreferenceValue.refreshToken,
              refreshToken,
            );
          }
          if (role != null) {
            await SharePrefsHelper.setString(SharedPreferenceValue.role, role);
          }
        }

        // Check role and navigate
        String role = await SharePrefsHelper.getString(
          SharedPreferenceValue.role,
        );

        if (role.toLowerCase() == 'applicant') {
          //Get.to(() => const PersonalInformationView());
          Get.to(() => const HomeView());
        } else if (role.toLowerCase() == 'recruiter') {
          Get.to(() => const RecruiterPanelView());
        } else {
          errorSnack('Role not found or unrecognized: $role');
        }
      } else {
        errorSnack(response.statusText ?? 'Incorrect email or password');
      }
    } catch (e) {
      errorSnack('Connection failed: $e');
    } finally {
      isLoading.value = false;
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
