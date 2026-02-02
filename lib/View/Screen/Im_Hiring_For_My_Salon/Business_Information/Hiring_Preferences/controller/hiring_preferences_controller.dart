import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import '../../../Recruiter_Panel/view/recruiter_panel_view.dart';

class HiringPreferencesController extends GetxController {
  var isLoading = false.obs;

  // Data for Roles
  final List<String> availableRoles = [
    'Hair Stylist',
    'Barber',
    'Colorist',
    'Nail Technician',
    'Makeup Artist',
    'Beauty Therapist',
  ];

  // Data for "Looking for"
  final List<String> availableWorkTypes = [
    'Full-time',
    'Part-time',
    'Freelance',
    'Chair rental',
  ];

  // Selected items (using Sets/Lists for multi-selection logic)
  var selectedRoles = <String>[].obs;
  var selectedWorkTypes = <String>[].obs;

  void toggleRole(String role) {
    if (selectedRoles.contains(role)) {
      selectedRoles.remove(role);
    } else {
      selectedRoles.add(role);
    }
  }

  void toggleWorkType(String type) {
    if (selectedWorkTypes.contains(type)) {
      selectedWorkTypes.remove(type);
    } else {
      selectedWorkTypes.add(type);
    }
  }

  void submitPreferences() {
    // Validation: Require at least one role and one work type?
    // The UI says "You're all set", implying they might be optional, but usually better to have data.
    // I'll leave validation loose for now as per "You're all set" vibe, or add soft validation.

    if (selectedRoles.isEmpty && selectedWorkTypes.isEmpty) {
      Get.snackbar(
        'Tip',
        'Select at least one preference to get better matches',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      // Not returning, allowing to proceed if that's the desired UX, or strictly return:
      // return;
    }

    isLoading.value = true;

    // Simulate API Call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Profile Created Successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate to Home / Dashboard
      Get.to(() => const RecruiterPanelView());
    });
  }
}
