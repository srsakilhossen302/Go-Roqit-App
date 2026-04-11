import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

import '../../Work_Experience/view/work_experience_view.dart';

class EducationController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;

  /// TEXT CONTROLLERS
  final degreeTitleController = TextEditingController();
  final majorController = TextEditingController();
  final instituteNameController = TextEditingController();
  final yearOfPassingController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();

  /// CERTIFICATE
  final ImagePicker _picker = ImagePicker();
  var certificatePath = ''.obs;

  @override
  void onClose() {
    degreeTitleController.dispose();
    majorController.dispose();
    instituteNameController.dispose();
    yearOfPassingController.dispose();
    durationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> pickCertificate(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        certificatePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void clearForm() {
    degreeTitleController.clear();
    majorController.clear();
    instituteNameController.clear();
    yearOfPassingController.clear();
    durationController.clear();
    descriptionController.clear();
    certificatePath.value = '';
  }

  void addEducation() {
    submitEducation();
  }

  Future<void> submitEducation() async {
    if (degreeTitleController.text.isEmpty ||
        instituteNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill required fields');
      return;
    }

    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final Map<String, dynamic> formDataMap = {
        "degreeTitle": degreeTitleController.text,
        "instituteName": instituteNameController.text,
        "major": majorController.text,
        "duration": durationController.text,
        "yearOfPassing": yearOfPassingController.text,
        "description": descriptionController.text,
      };

      if (certificatePath.value.isNotEmpty) {
        final file = File(certificatePath.value);
        if (await file.exists()) {
          formDataMap["certificate"] = MultipartFile(
            await file.readAsBytes(),
            filename: certificatePath.value.split('/').last,
            contentType: 'image/jpeg',
          );
        }
      }

      final body = FormData(formDataMap);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.postData(ApiUrl.addEducation, body, headers: headers);

      print("Education Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Education Added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => const WorkExperienceView());
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to add education',
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
    Get.to(() => const WorkExperienceView());
  }
}
