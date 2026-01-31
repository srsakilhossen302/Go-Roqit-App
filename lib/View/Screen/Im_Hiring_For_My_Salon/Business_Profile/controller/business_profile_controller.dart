import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import '../../Hiring_Preferences/view/hiring_preferences_view.dart';

class BusinessProfileController extends GetxController {
  /// OBSERVABLES
  var isLoading = false.obs;
  var selectedBusinessType = ''.obs; // 'Salon', 'Barbershop', 'Spa', 'Mobile'

  // List to hold image paths or objects. Using String for paths for now.
  // We have 3 slots.
  var galleryImages = <String?>[null, null, null].obs;

  /// TEXT CONTROLLERS
  final aboutController = TextEditingController();

  /// Constants for Business Types
  final List<String> businessTypes = ['Salon', 'Barbershop', 'Spa', 'Mobile'];

  @override
  void onClose() {
    aboutController.dispose();
    super.onClose();
  }

  void selectBusinessType(String type) {
    selectedBusinessType.value = type;
  }

  Future<void> pickImage(int index, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        galleryImages[index] = image.path;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void submitBusinessProfile() {
    if (selectedBusinessType.value.isEmpty || aboutController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a business type and describe your salon',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API Call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Business Profile Saved',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.bottom,
      );

      // Navigate to Next Step (Step 3 of 3)
      Get.to(() => const HiringPreferencesView());
    });
  }
}
