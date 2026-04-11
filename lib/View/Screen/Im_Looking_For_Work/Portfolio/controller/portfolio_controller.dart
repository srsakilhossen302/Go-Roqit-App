import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

import '../../Additional_Information/view/additional_information_view.dart';

import 'package:image_picker/image_picker.dart';

class PortfolioController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var selectedImages = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  /// TEXT CONTROLLERS
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
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

  void addPortfolio() {
    if (titleController.text.isEmpty || selectedImages.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add a title and upload at least one image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      return;
    }
    submitPortfolio();
  }

  Future<void> submitPortfolio() async {
    if (titleController.text.isEmpty || selectedImages.isEmpty) {
      Get.snackbar('Error', 'Please fill required fields');
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

      // Add multiple files
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

      print("Portfolio Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Portfolio Added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => const AdditionalInformationView());
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

  void skipStep() {
    // Logic to skip
    print("Skip Step");
  }
}
