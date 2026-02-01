import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import '../../Job_Posts/model/job_post_model.dart';
import 'package:flutter/widgets.dart';

class PostJobController extends GetxController {
  // Form Controllers
  final jobTitleController = TextEditingController();
  final roleTypeController = TextEditingController();
  final locationController = TextEditingController();
  final employmentTypeController = TextEditingController();

  final isEditMode = false.obs;
  String? editingJobId;

  @override
  void onInit() {
    super.onInit();

    // Check for arguments (Edit Mode)
    if (Get.arguments != null && Get.arguments is JobPostModel) {
      final JobPostModel job = Get.arguments;
      isEditMode.value = true;
      editingJobId = job.id;

      // Pre-fill fields
      jobTitleController.text = job.title;
      roleTypeController.text = job.roleType;
      locationController.text = job.location;
      employmentTypeController.text = job.employmentType;
    }
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    roleTypeController.dispose();
    locationController.dispose();
    employmentTypeController.dispose();
    super.onClose();
  }

  void onContinue() {
    if (jobTitleController.text.isEmpty || locationController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in required fields');
      return;
    }

    // Proceed to Step 2 or Save if simulating
    Get.snackbar(
      'Success',
      isEditMode.value ? 'Job Updated' : 'Step 1 Complete',
    );
  }
}
