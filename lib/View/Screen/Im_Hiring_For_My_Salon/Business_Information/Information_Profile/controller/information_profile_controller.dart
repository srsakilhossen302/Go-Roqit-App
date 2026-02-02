import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Hiring_Preferences/view/hiring_preferences_view.dart';

class InformationProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Business Type Selection
  final selectedBusinessType = Rxn<String>();
  final businessTypes = ['Salon', 'Barbershop', 'Spa', 'Mobile'];

  // About Text Controller
  final aboutController = TextEditingController();

  // Gallery
  final galleryImages = <String>[].obs;

  // Loading State
  final isLoading = false.obs;

  void selectBusinessType(String type) {
    selectedBusinessType.value = type;
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
      Get.snackbar('Required', 'Please select a business type');
      return;
    }

    // Start loading
    isLoading.value = true;

    // Simulate network delay (lod niya)
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    // Proceed to next step
    Get.to(() => const HiringPreferencesView());
  }

  @override
  void onClose() {
    aboutController.dispose();
    super.onClose();
  }
}
