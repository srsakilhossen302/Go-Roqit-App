import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class PortfolioController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var uploadedFileName = 'Browse Files to upload'.obs;

  /// TEXT CONTROLLERS
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void pickImage() {
    // Logic to pick image
    uploadedFileName.value = "image_001.jpg"; // Simulate picked file
  }

  void addPortfolio() {
    if (titleController.text.isEmpty ||
        uploadedFileName.value == 'Browse Files to upload') {
      Get.snackbar(
        'Error',
        'Please add a title and upload an image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    // Logic to add portfolio to list
    Get.snackbar(
      'Success',
      'Portfolio Item Added',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.bottom,
    );
    // Clear form
    titleController.clear();
    descriptionController.clear();
    uploadedFileName.value = 'Browse Files to upload';
  }

  void submitPortfolio() {
    // API CALL to save portfolio details
    isLoading.value = true;

    // Simulate API Call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Portfolio Saved',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate to next step
      // Get.to(() => NextStepView());
    });
  }

  void skipStep() {
    // Logic to skip
    print("Skip Step");
  }
}
