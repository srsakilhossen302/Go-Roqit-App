import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../../Im_Hiring_For_My_Salon/Business_Information/Business_basics/view/business_information_view.dart';
import '../../../Im_Looking_For_Work/Personal_Information/view/personal_information_view.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var email = ''.obs;
  var isLoading = false.obs;

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
    if (pinController.text.length == 6) {
      isLoading.value = true;
      try {
        final apiClient = Get.find<ApiClient>();
        final body = {
          "email": email.value,
          "oneTimeCode": pinController.text
        };

        final response = await apiClient.postData(ApiUrl.otpVerify, body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar(
            'Success',
            'Account Verified successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          String role = await SharePrefsHelper.getString(
            SharedPreferenceValue.role,
          );

          if (role == 'applicant') {
            Get.offAll(() => const PersonalInformationView());
          } else if (role == 'recruiter') {
            Get.offAll(() => const BusinessInformationView());
          }
        } else {
          Get.snackbar(
            'Error',
            response.statusText ?? 'Verification failed',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Connection Error: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter 6 digits',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
