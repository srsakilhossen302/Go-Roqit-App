import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../Job_Posts/model/job_post_model.dart';

class PostJobController extends GetxController {
  var currentStep = 1.obs;

  // Step 1: Job Basics
  final jobTitleController = TextEditingController();
  final roleTypeController = TextEditingController();
  final locationController = TextEditingController();
  final employmentTypeController = TextEditingController();

  // Step 2: Compensation
  final minSalaryController = TextEditingController();
  final maxSalaryController = TextEditingController();
  final salaryTypeController = TextEditingController();
  final benefitsController = TextEditingController();

  // Step 3: Job Details
  final descriptionController = TextEditingController();
  final requirementsController = TextEditingController();
  final workScheduleController = TextEditingController();
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

    // Check for arguments (Edit Mode)
    if (Get.arguments != null && Get.arguments is JobPostModel) {
      final JobPostModel job = Get.arguments;
      isEditMode.value = true;
      editingJobId = job.id;

      // Step 1
      jobTitleController.text = job.title;
      roleTypeController.text = job.roleType;
      locationController.text = job.location;
      employmentTypeController.text = job.employmentType;

      // Step 2
      minSalaryController.text = job.minSalary;
      maxSalaryController.text = job.maxSalary;
      salaryTypeController.text = job.salaryType;
      benefitsController.text = job.benefits;

      // Step 3
      descriptionController.text = job.description;
      requirementsController.text = job.requirements.join('\n');
      workScheduleController.text = job.workSchedule;
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
    benefitsController.dispose();
    descriptionController.dispose();
    requirementsController.dispose();
    workScheduleController.dispose();
    super.onClose();
  }

  void onContinue() {
    if (currentStep.value < 4) {
      // Basic validation for each step
      if (currentStep.value == 1) {
        if (jobTitleController.text.isEmpty ||
            locationController.text.isEmpty) {
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

  Future<void> _publishJob() async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final body = {
        "title": jobTitleController.text,
        "category": roleTypeController.text,
        "type": employmentTypeController.text,
        "engagementType": engagementTypeController.text.isNotEmpty 
            ? engagementTypeController.text : "Salaried",
        "startDate": DateTime.now().toIso8601String(),
        "salryType": salaryTypeController.text,
        "minSalary": int.tryParse(minSalaryController.text) ?? 0,
        "maxSalary": int.tryParse(maxSalaryController.text) ?? 0,
        "description": descriptionController.text,
        "jobLocation": locationController.text,
        "experianceLabel": experienceLabelController.text.isNotEmpty 
            ? experienceLabelController.text : "Mid-level"
      };

      final headers = {'Authorization': 'Bearer $token'};
      
      // Using /job endpoint as per screenshot
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
