import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import '../../Job_Posts/model/job_post_model.dart';
import 'package:flutter/widgets.dart';

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
      // Final Step (4) - Publish
      Get.snackbar(
        'Success',
        isEditMode.value ? 'Job Updated' : 'Job Posted Successfully',
      );
      Get.back(); // Or navigate to some success page/Job list
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
