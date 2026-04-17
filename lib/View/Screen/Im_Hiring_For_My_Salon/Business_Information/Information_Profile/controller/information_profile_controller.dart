import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:get_x/get_connect.dart';
import 'package:go_roqit_app/View/Screen/Im_Hiring_For_My_Salon/Post_Job/model/category_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../../Recruiter_Panel/view/recruiter_panel_view.dart';
import '../../Hiring_Preferences/view/hiring_preferences_view.dart';

class InformationProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Business Type Selection
  final selectedBusinessType = Rxn<CategoryModel>();
  final categoryList = <CategoryModel>[].obs;
  final isLoadingCategories = false.obs;

  // About Text Controller
  final aboutController = TextEditingController();

  // Gallery
  final galleryImages = <String>[].obs;

  // Loading State
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoadingCategories.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final response = await apiClient.getData(ApiUrl.getCategories);
      print("Categories Status: ${response.statusCode}");
      print("Categories Body: ${response.body}");

      if (response.statusCode == 200 && response.body != null) {
        dynamic rawData = response.body['data'];
        List<dynamic> dataList = [];

        if (rawData is List) {
          dataList = rawData;
        } else if (rawData is Map && rawData['data'] is List) {
          dataList = rawData['data'];
        }

        print("Categories Data List length: ${dataList.length}");
        categoryList.assignAll(
          dataList.map((e) => CategoryModel.fromJson(e)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to load categories');
      }
    } catch (e) {
      print("Categories Error: $e");
      Get.snackbar('Error', 'An error occurred while fetching categories');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void selectBusinessType(CategoryModel category) {
    selectedBusinessType.value = category;
  }

  Future<void> pickGalleryImage() async {
    try {
      if (galleryImages.length >= 3) {
        Get.snackbar('Limit Reached', 'You can only upload up to 3 images.');
        return;
      }
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        galleryImages.add(image.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void removeImage(int index) {
    galleryImages.removeAt(index);
  }

  Future<void> onContinue() async {
    // Validate inputs
    if (selectedBusinessType.value == null) {
      Get.snackbar(
        'Required',
        'Please select a business type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (aboutController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'Please describe your salon',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (galleryImages.isEmpty) {
      Get.snackbar(
        'Required',
        'Please upload at least one image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();

      // Prepare files
      final portfolioFiles = <MultipartFile>[];
      for (var path in galleryImages) {
        final bytes = await File(path).readAsBytes();
        portfolioFiles.add(
          MultipartFile(
            bytes,
            filename: path.split('/').last,
            contentType: 'image/jpeg',
          ),
        );
      }

      final body = FormData({
        "title": selectedBusinessType.value?.name ?? "Business Portfolio",
        "description": aboutController.text,
        "portfolio": portfolioFiles,
      });

      final token = await SharePrefsHelper.getString(
        SharedPreferenceValue.token,
      );
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.postData(
        ApiUrl.addPortfolio,
        body,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Success Body: ${response.body}");
        Get.snackbar(
          'Success',
          'Portfolio added successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Proceed to next step
        // Get.to(() => const HiringPreferencesView());
        Get.to(() => const RecruiterPanelView());
      } else {
        print("Error Status Code: ${response.statusCode}");
        print("Error Body: ${response.body}");
        Get.snackbar(
          'Error',
          response.statusText ?? 'Something went wrong',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Connection Error: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    aboutController.dispose();
    super.onClose();
  }
}
