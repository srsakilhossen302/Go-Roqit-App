import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

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

  void submitBusinessInfo() {
    if (businessNameController.text.isEmpty ||
        contactNameController.text.isEmpty ||
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

    // Simulate API Call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Business Basics Saved',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate to Next Step (Step 2 of 3)
      // Get.to(() => NextStepView());
    });
  }
}
