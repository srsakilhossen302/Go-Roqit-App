import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:go_roqit_app/Utils/Toast/toast.dart';
import '../model/additional_information_model.dart';

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
      resumeFileName: profile?.resume != null ? profile!.resume!.split('/').last : "Resume.pdf",
      resumeLastUpdated: profile?.updatedAt?.split('T').first ?? "Not set",
      resumeUrl: profile?.resume,
      professionalSummary: "", 
      skills: profile?.skills ?? [],
      languages: profile?.languages ?? [],
      workPreferences: [], 
      salaryExpectation: "Not set", 
    ).obs;
  }

  void refreshData() {
    _profileController.fetchProfile().then((_) => _updateModel());
  }

  Future<void> updateSummary(String text) async {
    additionalInfoModel.value.professionalSummary = text;
    additionalInfoModel.refresh();
  }

  Future<void> updateSkills(List<String> skills) async {
    await _updateProfile(payload: {"skills": skills});
  }

  Future<void> updateLanguages(List<String> languages) async {
    await _updateProfile(payload: {"languages": languages});
  }

  Future<void> updateWorkPreferences(List<String> prefs, String salary) async {
    additionalInfoModel.value.workPreferences = prefs;
    additionalInfoModel.value.salaryExpectation = salary;
    additionalInfoModel.refresh();
  }

  Future<void> updateResume() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;
        
        await _updateProfile(
          resumeFile: MultipartFile(filePath, filename: fileName, contentType: 'application/pdf'),
        );
      }
    } catch (e) {
      ToastHelper.error("Failed to pick file: $e");
    }
  }

  void viewResume() async {
    String? url = additionalInfoModel.value.resumeUrl;
    if (url != null && url.isNotEmpty) {
      if (!url.startsWith('http')) {
        url = "${ApiUrl.IMGUrl}$url";
      }
      
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ToastHelper.error("Could not launch resume URL");
      }
    } else {
      ToastHelper.warning("No resume uploaded yet");
    }
  }

  Future<void> _updateProfile({Map<String, dynamic>? payload, MultipartFile? resumeFile}) async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final Map<String, dynamic> formDataMap = {};
      if (payload != null) {
        formDataMap["data"] = jsonEncode(payload);
      }
      if (resumeFile != null) {
        formDataMap["resume"] = resumeFile;
      }

      final body = FormData(formDataMap);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(ApiUrl.updateProfile, body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastHelper.success('Profile updated successfully 🚀');
        refreshData();
      } else {
        String errMsg = response.body?['message'] ?? 'Failed to update details';
        ToastHelper.error(errMsg);
      }
    } catch (e) {
      ToastHelper.error('Connection Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
