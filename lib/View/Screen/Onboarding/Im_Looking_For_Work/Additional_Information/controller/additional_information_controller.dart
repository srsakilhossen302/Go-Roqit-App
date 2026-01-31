import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class AdditionalInformationController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var selectedWorkType = ''.obs;
  var selectedLanguages = <String>[].obs;
  var salaryFrequency = 'Per Year'.obs;
  var skills = <String>[].obs;
  var uploadedResumeName = 'Click to upload or drag and drop'.obs;
  var bioCharacterCount = 0.obs;

  /// TEXT CONTROLLERS
  final salaryController = TextEditingController();
  final bioController = TextEditingController();
  final skillInputController = TextEditingController();

  /// STATIC DATA
  final workTypes = ['Full Time', 'Part Time', 'Contract'];
  final languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Mandarin',
    'Arabic',
    'Bengali',
    'Hindi',
  ];
  final salaryFrequencies = ['Per Year', 'Per Month', 'Per Hour', 'Part time'];

  @override
  void onInit() {
    super.onInit();
    bioController.addListener(() {
      bioCharacterCount.value = bioController.text.length;
    });
  }

  @override
  void onClose() {
    salaryController.dispose();
    bioController.dispose();
    skillInputController.dispose();
    super.onClose();
  }

  void selectWorkType(String type) {
    selectedWorkType.value = type;
  }

  void toggleLanguage(String language) {
    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    } else {
      selectedLanguages.add(language);
    }
  }

  void setSalaryFrequency(String? value) {
    if (value != null) {
      salaryFrequency.value = value;
    }
  }

  void addSkill() {
    if (skillInputController.text.isNotEmpty) {
      if (!skills.contains(skillInputController.text)) {
        skills.add(skillInputController.text);
        skillInputController.clear();
      } else {
        Get.snackbar(
          'Note',
          'Skill already added',
          snackPosition: SnackPosition.bottom,
        );
      }
    }
  }

  void removeSkill(String skill) {
    skills.remove(skill);
  }

  void pickResume() {
    // Logic to pick PDF
    uploadedResumeName.value = "my_resume.pdf";
  }

  void submitApplication() {
    if (selectedWorkType.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a preferred work type',
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
        'Application Completed Successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate to Dashboard or Home
      // Get.offAll(() => HomeView());
    });
  }

  void skipStep() {
    // Logic to skip
    print("Skip Step");
  }
}
