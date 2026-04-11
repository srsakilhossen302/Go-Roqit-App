import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

import 'package:image_picker/image_picker.dart';

import '../../Home/view/home_view.dart';

class AdditionalInformationController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var selectedWorkType = ''.obs;
  var selectedLanguages = <String>[].obs;
  var salaryFrequency = 'yearly'.obs;
  var skills = <String>[].obs;
  var uploadedResumeName = 'Click to upload or drag and drop'.obs;
  var resumePath = ''.obs;
  var bioCharacterCount = 0.obs;

  final ImagePicker _picker = ImagePicker();

  /// TEXT CONTROLLERS
  final salaryController = TextEditingController();
  final bioController = TextEditingController();
  final skillInputController = TextEditingController();

  /// STATIC DATA
  final workTypes = ['Full-time', 'Part-time', 'Temp', 'Self-employed', 'Chair-rental'];
  final languagesList = [
    'English',
    'Spanish',
    'French',
    'German',
    'Mandarin',
    'Arabic',
    'Bengali',
    'Hindi',
  ];
  final salaryFrequencies = ['yearly', 'monthly', 'weekly', 'hourly'];

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

  Future<void> pickResume() async {
    try {
      // Simulate picking a file using ImagePicker
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        uploadedResumeName.value = file.name;
        resumePath.value = file.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick file: $e');
    }
  }

  Future<void> submitApplication() async {
    if (selectedWorkType.isEmpty) {
      Get.snackbar('Error', 'Please select a preferred work type');
      return;
    }

    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token =
          await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final dataBody = {
        "preferredWorkType": selectedWorkType.value,
        "languages": selectedLanguages.toList(),
        "salaryExpectation": {
          "type": salaryFrequency.value,
          "amount": double.tryParse(salaryController.text) ?? 0,
        },
        "bio": bioController.text,
        "skills": skills.toList(),
      };

      final Map<String, dynamic> formDataMap = {
        "data": jsonEncode(dataBody),
      };

      if (resumePath.value.isNotEmpty) {
        final file = File(resumePath.value);
        if (await file.exists()) {
          formDataMap["resume"] = MultipartFile(
            await file.readAsBytes(),
            filename: resumePath.value.split('/').last,
            contentType: 'application/pdf',
          );
        }
      }

      final body = FormData(formDataMap);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(ApiUrl.updateProfile, body,
          headers: headers);

      print(
          "Additional Info Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => HomeView());
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to update profile',
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
