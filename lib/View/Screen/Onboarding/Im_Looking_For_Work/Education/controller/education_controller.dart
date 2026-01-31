import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class EducationController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;

  /// TEXT CONTROLLERS
  final levelOfEducationController = TextEditingController();
  final degreeTitleController = TextEditingController();
  final majorController = TextEditingController();
  final instituteNameController = TextEditingController();
  final cgpaController = TextEditingController();
  final scaleController = TextEditingController();
  final yearOfPassingController = TextEditingController();
  final durationController = TextEditingController();

  @override
  void onClose() {
    levelOfEducationController.dispose();
    degreeTitleController.dispose();
    majorController.dispose();
    instituteNameController.dispose();
    cgpaController.dispose();
    scaleController.dispose();
    yearOfPassingController.dispose();
    durationController.dispose();
    super.onClose();
  }

  void addEducation() {
    if (levelOfEducationController.text.isEmpty ||
        degreeTitleController.text.isEmpty ||
        instituteNameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    // Logic to add education to a list (locally)
    Get.snackbar(
      'Success',
      'Education Added',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.bottom,
    );
  }

  void clearForm() {
    levelOfEducationController.clear();
    degreeTitleController.clear();
    majorController.clear();
    instituteNameController.clear();
    cgpaController.clear();
    scaleController.clear();
    yearOfPassingController.clear();
    durationController.clear();
  }

  void submitEducation() {
    // API CALL to save education details
    isLoading.value = true;

    // Simulate API Call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Education Details Saved',
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
