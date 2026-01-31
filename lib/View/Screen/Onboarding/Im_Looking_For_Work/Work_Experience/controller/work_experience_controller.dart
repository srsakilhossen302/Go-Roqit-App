import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

import '../../Portfolio/view/portfolio_view.dart';

class WorkExperienceController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var isCurrentlyWorking = false.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;

  /// TEXT CONTROLLERS
  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final locationController = TextEditingController();
  final employmentTypeController = TextEditingController();

  @override
  void onClose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    locationController.dispose();
    employmentTypeController.dispose();
    super.onClose();
  }

  void toggleCurrentlyWorking(bool? value) {
    isCurrentlyWorking.value = value ?? false;
  }

  Future<void> selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B5E3F),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1B5E3F),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      String formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (isStart) {
        startDate.value = formattedDate;
      } else {
        endDate.value = formattedDate;
      }
    }
  }

  void addExperience() {
    if (jobTitleController.text.isEmpty ||
        companyNameController.text.isEmpty ||
        employmentTypeController.text.isEmpty ||
        startDate.value.isEmpty) {
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
      'Work Experience Added',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.bottom,
    );
  }

  void clearForm() {
    jobTitleController.clear();
    companyNameController.clear();
    locationController.clear();
    employmentTypeController.clear();
    startDate.value = '';
    endDate.value = '';
    isCurrentlyWorking.value = false;
  }

  void submitWorkExperience() {
    // API CALL to save education details
    isLoading.value = true;

    // Simulate API Call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Work Experience Saved',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate to next step
      Get.to(() => const PortfolioView());
    });
  }

  void skipStep() {
    // Logic to skip
    print("Skip Step");
  }
}
