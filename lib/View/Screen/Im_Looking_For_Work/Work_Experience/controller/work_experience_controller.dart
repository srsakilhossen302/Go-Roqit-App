import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

import '../../Portfolio/view/portfolio_view.dart';

class WorkExperienceController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var isCurrentlyWorking = false.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var selectedEmploymentType = ''.obs;

  /// TEXT CONTROLLERS
  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final locationController = TextEditingController();
  final employmentTypeController = TextEditingController();
  final experienceController = TextEditingController(); 

  final employmentTypes = [
    'Full-time',
    'Part-time',
    'Temp',
    'Self-employed',
    'Chair-rental'
  ];

  @override
  void onClose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    locationController.dispose();
    employmentTypeController.dispose();
    experienceController.dispose();
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
    selectedEmploymentType.value = '';
    experienceController.clear();
    startDate.value = '';
    endDate.value = '';
    isCurrentlyWorking.value = false;
  }

  Future<void> submitWorkExperience() async {
    if (jobTitleController.text.isEmpty ||
        companyNameController.text.isEmpty ||
        selectedEmploymentType.isEmpty ||
        startDate.value.isEmpty) {
      Get.snackbar('Error', 'Please fill required fields');
      return;
    }

    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(
        SharedPreferenceValue.token,
      );

      final Map<String, dynamic> workExperienceData = {
        "jobTitle": jobTitleController.text,
        "companyName": companyNameController.text,
        "location": locationController.text,
        "employmentType": selectedEmploymentType.value,
        "startDate": startDate.value,
        "endDate": isCurrentlyWorking.value ? null : endDate.value,
        "experience": experienceController.text,
      };

      final body = FormData({
        "data": jsonEncode({
          "workExperience": [workExperienceData] 
        }),
      });

      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(
        ApiUrl.updateProfile,
        body,
        headers: headers,
      );

      print(
        "Work Experience Response: ${response.statusCode} - ${response.body}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Work Experience Added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => const PortfolioView());
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to add work experience',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void skipStep() {
    // Logic to skip
    print("Skip Step");
  }
}
