import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:get_x/get_connect.dart';
import 'dart:convert';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../Information_Profile/view/information_profile_view.dart';

class BusinessInformationController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;

  /// TEXT CONTROLLERS
  final businessNameController = TextEditingController();
  final contactNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onClose() {
    businessNameController.dispose();
    contactNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  void useCurrentLocation() {
    // Logic to get current location
    addressController.text =
        "123 Current Location St, London, UK"; // specific mock
  }

  Future<void> submitBusinessInfo() async {
    if (businessNameController.text.isEmpty ||
        // contactNameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        addressController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();

      final dataBody = {
        "companyName": businessNameController.text,
        "phone": phoneNumberController.text,
        "location": addressController.text,
      };

      final body = FormData({
        "data": jsonEncode(dataBody),
      });

      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await apiClient.patchData(ApiUrl.updateProfile, body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Success Body: ${response.body}");
        Get.snackbar(
          'Success',
          'Business Basics Saved',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.bottom,
        );

        // Navigate to Next Step (Step 2 of 3)
        Get.to(() => InformationProfileView());
      } else {
        print("Error Status Code: ${response.statusCode}");
        print("Error Body: ${response.body}");
        Get.snackbar(
          'Error',
          response.statusText ?? 'Something went wrong',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.bottom,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Connection Error: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
