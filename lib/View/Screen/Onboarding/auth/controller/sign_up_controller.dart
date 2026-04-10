import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../otp/view/otp_view.dart';

class SignUpController extends GetxController {
  var isSignUp = true.obs;
  var isLoading = false.obs;

  // Sign up controllers
  final fullName = TextEditingController();
  final signUpEmail = TextEditingController();
  final signUpPassword = TextEditingController();
  final companyName = TextEditingController();

  var selectedRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRole();
  }

  Future<void> getRole() async {
    selectedRole.value = await SharePrefsHelper.getString(SharedPreferenceValue.role);
  }

  void switchTab(bool value) {
    isSignUp.value = value;
  }

  /// SIGN UP FLOW
  Future<void> signUp() async {
    if (fullName.text.isEmpty ||
        signUpEmail.text.isEmpty ||
        signUpPassword.text.isEmpty ||
        (selectedRole.value == 'recruiter' && companyName.text.isEmpty)) {
      errorSnack('Please fill all fields');
      return;
    }

    isLoading.value = true;

    // Fetch role from SharedPreferences
    String role = await SharePrefsHelper.getString(SharedPreferenceValue.role);
    print("Retrieved Role: $role");

    // Prepare request body
    Map<String, dynamic> body = {
      "name": fullName.text,
      "email": signUpEmail.text,
      "password": signUpPassword.text,
      "role": selectedRole.value,
    };

    if (selectedRole.value == 'recruiter') {
      body["companyName"] = companyName.text;
    }

    try {
      // Hit the API
      print("Sign Up Body: $body");
      final response = await Get.find<ApiClient>().postData(ApiUrl.signUp, body);
      print("Sign Up Status Code: ${response.statusCode}");
      print("Sign Up Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        successSnack('Account created successfully');
        // Passing email to OTP view as an argument
        Get.to(() => const OtpView(), arguments: signUpEmail.text);
      } else {
        errorSnack(response.statusText ?? 'Something went wrong');
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
