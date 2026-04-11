import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../model/profile_model.dart';

class ProfileWorkExperienceController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  RxList<WorkExperience> get workExperiences => 
    (_profileController.userData.value?.profile?.workExperience ?? <WorkExperience>[]).obs;

  var isLoading = false.obs;
  var isCurrentlyWorking = false.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var selectedEmploymentType = ''.obs;

  final jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final locationController = TextEditingController();
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
    experienceController.dispose();
    super.onClose();
  }

  void refreshData() {
    _profileController.fetchProfile();
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
      Get.snackbar('Error', 'Please fill required fields (Title, Company, Type, Start Date)');
      return;
    }

    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      // Backend expects the NEW item to be appended to existing list or it appends automatically?
      // Assuming the backend appends automatically because the original onboarding sends an array of 1 object.
      // Wait, let's just append our new data to the existing list and send the full list to be safe,
      // or send just the new one. The original Controller sent only the new one:
      // "workExperience": [workExperienceData]
      
      // Let's get the existing work experiences just in case it overwrites,
      // but original code sends `[workExperienceData]` so let's try to append to existing list and send that.
      // Wait, if it's PATCH /user/profile, often PATCH on an array replaces it.
      // Let's send the combined list.
      List<Map<String, dynamic>> existingList = workExperiences.map((e) => {
        "jobTitle": e.jobTitle,
        "companyName": e.companyName,
        "location": e.location,
        "employmentType": e.employmentType,
        "startDate": e.startDate,
        "endDate": e.endDate,
        "experience": e.experience,
      }).toList();

      existingList.add({
        "jobTitle": jobTitleController.text,
        "companyName": companyNameController.text,
        "location": locationController.text,
        "employmentType": selectedEmploymentType.value,
        "startDate": startDate.value,
        "endDate": isCurrentlyWorking.value ? null : endDate.value,
        "experience": experienceController.text,
      });

      final body = FormData({
        "data": jsonEncode({
          "workExperience": existingList
        }),
      });

      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(ApiUrl.updateProfile, body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // close Bottom Sheet
        Get.snackbar(
          'Success',
          'Work Experience Added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearForm();
        refreshData();
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
}
