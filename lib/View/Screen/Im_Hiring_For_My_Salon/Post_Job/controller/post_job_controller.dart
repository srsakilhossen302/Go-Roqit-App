import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:geolocator/geolocator.dart';
import '../../Job_Posts/model/job_post_model.dart';
import '../model/category_model.dart';


class PostJobController extends GetxController {
  var currentStep = 1.obs;

  // Location Coordinates
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var startDate = DateTime.now().obs;

  var categories = <String>[].obs;
  var categoryObjects = <CategoryModel>[].obs;
  var isCategoryLoading = false.obs;
  final engagementTypes = ["Salaried", "Self-employed", "Contract", "Freelance"];


  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
    }
  }

  // Step 1: Job Basics
  final jobTitleController = TextEditingController();
  final roleTypeController = TextEditingController();
  final locationController = TextEditingController();
  final employmentTypeController = TextEditingController();

  // Step 2: Compensation
  final minSalaryController = TextEditingController();
  final maxSalaryController = TextEditingController();
  final salaryTypeController = TextEditingController();

  // Step 3: Job Details
  final descriptionController = TextEditingController();
  final experienceLabelController = TextEditingController(); // New
  final engagementTypeController = TextEditingController(); // New

  final isLoading = false.obs;
  final isEditMode = false.obs;
  String? editingJobId;

  // For Review Screen (Step 4)
  // Computed properties or just use the controllers directly in the view

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation(); // Auto-fetch location on start
    fetchCategories(); // Fetch categories from API


    // Check for arguments (Edit Mode)
    if (Get.arguments != null && Get.arguments is JobPostModel) {
      final JobPostModel job = Get.arguments;
      isEditMode.value = true;
      editingJobId = job.id;

      // Step 1
      jobTitleController.text = job.title;
      roleTypeController.text = job.category;
      locationController.text = job.jobLocation;
      employmentTypeController.text = job.employmentType;
      engagementTypeController.text = job.engagementType;
      if (job.startDate.isNotEmpty) {
        startDate.value = DateTime.tryParse(job.startDate) ?? DateTime.now();
      }

      // Step 2
      minSalaryController.text = job.minSalary.toString();
      maxSalaryController.text = job.maxSalary.toString();
      salaryTypeController.text = job.paymentType;
      // Step 3
      descriptionController.text = job.description;
      experienceLabelController.text = job.experienceLabel;
    }
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    roleTypeController.dispose();
    locationController.dispose();
    employmentTypeController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    salaryTypeController.dispose();
    descriptionController.dispose();
    experienceLabelController.dispose();
    engagementTypeController.dispose();
    super.onClose();
  }

  void onContinue() {
    if (currentStep.value < 4) {
      // Basic validation for each step
      if (currentStep.value == 1) {
        if (jobTitleController.text.isEmpty) {
          Get.snackbar('Error', 'Please fill in required fields');
          return;
        }
      } else if (currentStep.value == 2) {
        if (minSalaryController.text.isEmpty ||
            maxSalaryController.text.isEmpty) {
          Get.snackbar('Error', 'Please fill in required fields');
          return;
        }
      } else if (currentStep.value == 3) {
        if (descriptionController.text.isEmpty) {
          Get.snackbar('Error', 'Please fill in required fields');
          return;
        }
      }

      currentStep.value++;
    } else {
      _publishJob();
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      print("Location Captured: ${latitude.value}, ${longitude.value}");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> fetchCategories() async {
    isCategoryLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final response = await apiClient.getData("/category");

      if (response.statusCode == 200 && response.body['data'] != null) {
        final List<dynamic> categoryData = response.body['data']['data'] ?? [];
        categoryObjects.value = categoryData
            .map((json) => CategoryModel.fromJson(json))
            .toList();
        categories.value = categoryObjects.map((cat) => cat.name).toList();
        print("Fetched categories: ${categories.value}");
      } else {
        Get.snackbar('Error', 'Failed to load categories');
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isCategoryLoading.value = false;
    }
  }


  Future<void> _publishJob() async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token =
          await SharePrefsHelper.getString(SharedPreferenceValue.token);

      // Normalization helpers to match backend enums
      String normalizedType = employmentTypeController.text.trim().toLowerCase();
      if (normalizedType.contains("full")) {
        normalizedType = "Full-time";
      } else if (normalizedType.contains("part")) {
        normalizedType = "Part-time";
      } else if (normalizedType.contains("temp")) {
        normalizedType = "Temp";
      } else {
        normalizedType = "Full-time"; // fallback
      }

      String normalizedSalaryType = salaryTypeController.text.trim().toLowerCase();
      if (normalizedSalaryType.contains("year")) {
        normalizedSalaryType = "yearly";
      } else if (normalizedSalaryType.contains("month")) {
        normalizedSalaryType = "monthly";
      } else if (normalizedSalaryType.contains("week")) {
        normalizedSalaryType = "weekly";
      } else if (normalizedSalaryType.contains("hour")) {
        normalizedSalaryType = "hourly";
      } else {
        normalizedSalaryType = "yearly"; // fallback
      }

      String normalizedExperience = experienceLabelController.text.trim().toLowerCase();
      if (normalizedExperience.contains("junior")) {
        normalizedExperience = "Junior";
      } else if (normalizedExperience.contains("mid")) {
        normalizedExperience = "Mid-Level";
      } else if (normalizedExperience.contains("senior")) {
        normalizedExperience = "Senior";
      } else if (normalizedExperience.contains("master")) {
        normalizedExperience = "Master";
      } else {
        normalizedExperience = "Mid-Level"; // fallback
      }

      final body = {
        "title": jobTitleController.text,
        "category": roleTypeController.text,
        "type": normalizedType,
        "engagementType": engagementTypeController.text.isNotEmpty
            ? engagementTypeController.text
            : "Salaried",
        "startDate": DateTime.utc(startDate.value.year, startDate.value.month, startDate.value.day).toIso8601String(),
        "paymentType": normalizedSalaryType,
        "minSalary": int.tryParse(minSalaryController.text) ?? 0,
        "maxSalary": int.tryParse(maxSalaryController.text) ?? 0,
        "description": descriptionController.text,
        "jobLocation": locationController.text.isNotEmpty 
            ? locationController.text 
            : "Real-time Location",
        "location": {
          "type": "Point",
          "coordinates": [longitude.value, latitude.value]
        },
        "experianceLabel": normalizedExperience,
      };

      final headers = {'Authorization': 'Bearer $token'};
      
      final response = await apiClient.postData("/job", body, headers: headers);

      print("Post Job Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          isEditMode.value ? 'Job Updated' : 'Job Posted Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to post job',
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

  void onBack() {
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }
}
