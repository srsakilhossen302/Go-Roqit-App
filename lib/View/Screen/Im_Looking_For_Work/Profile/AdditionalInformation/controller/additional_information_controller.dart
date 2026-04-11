import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/additional_information_model.dart';
import 'package:go_roqit_app/service/api_client.dart';

class ProfileAdditionalInformationController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  late Rx<AdditionalInformationModel> additionalInfoModel;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _updateModel();
  }

  void _updateModel() {
    final profile = _profileController.userData.value?.profile;
    
    additionalInfoModel = AdditionalInformationModel(
      resumeFileName: "Resume.pdf", // Backend doesn't provide file name directly
      resumeLastUpdated: profile?.updatedAt?.split('T').first ?? "Not set",
      professionalSummary: "", // Not found in JSON
      skills: profile?.skills ?? [],
      languages: profile?.languages ?? [],
      workPreferences: [], // Not found in JSON
      salaryExpectation: "Not set", // Not found in JSON
    ).obs;
  }

  void refreshData() {
    _profileController.fetchProfile().then((_) => _updateModel());
  }

  Future<void> updateSummary(String text) async {
    // There is no professionalSummary in profile JSON currently, but simulating API
    // If backend supports it:
    // await _updateProfile({"professionalSummary": text});
    additionalInfoModel.value.professionalSummary = text;
    additionalInfoModel.refresh();
  }

  Future<void> updateSkills(List<String> skills) async {
    await _updateProfile({"skills": skills});
  }

  Future<void> updateLanguages(List<String> languages) async {
    await _updateProfile({"languages": languages});
  }

  Future<void> updateWorkPreferences(List<String> prefs, String salary) async {
    // If backend supports:
    // await _updateProfile({"workPreferences": prefs, "salaryExpectation": salary});
    additionalInfoModel.value.workPreferences = prefs;
    additionalInfoModel.value.salaryExpectation = salary;
    additionalInfoModel.refresh();
  }

  Future<void> _updateProfile(Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final body = FormData({
        "data": jsonEncode(payload),
      });

      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(ApiUrl.updateProfile, body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Details updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        refreshData();
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to update details',
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

  void updateResume() {
    // Logic to update resume (e.g., File Picker)
  }

  void viewResume() {
    // Logic to view resume (e.g., Open PDF)
  }
}
