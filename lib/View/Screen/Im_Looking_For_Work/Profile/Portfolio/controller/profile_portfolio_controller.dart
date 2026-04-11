import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../model/profile_model.dart';

class ProfilePortfolioController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  RxList<Portfolio> get portfolioItems => 
    (_profileController.userData.value?.profile?.portfolio ?? <Portfolio>[]).obs;

  var isLoading = false.obs;
  var selectedImages = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void refreshData() {
    _profileController.fetchProfile();
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedImages.clear();
  }

  Future<void> pickImage() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick files: $e');
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> submitPortfolio() async {
    if (titleController.text.isEmpty || selectedImages.isEmpty) {
      Get.snackbar('Error', 'Please fill required fields and add at least one image');
      return;
    }

    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final Map<String, dynamic> formDataMap = {
        "title": titleController.text,
        "description": descriptionController.text,
      };

      List<MultipartFile> imageFiles = [];
      for (var xFile in selectedImages) {
        final file = File(xFile.path);
        if (await file.exists()) {
          imageFiles.add(MultipartFile(
            await file.readAsBytes(),
            filename: xFile.name,
            contentType: 'image/jpeg',
          ));
        }
      }

      if (imageFiles.isNotEmpty) {
        formDataMap["portfolio"] = imageFiles;
      }

      final body = FormData(formDataMap);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.postData(ApiUrl.addPortfolio, body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(); // close Bottom Sheet
        Get.snackbar(
          'Success',
          'Portfolio Added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearForm();
        refreshData();
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to add portfolio',
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
