import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

import '../../Education/view/education_view.dart';

class PersonalInformationController extends GetxController {
  /// OBSERVABLES
  var selectedGender = ''.obs;
  var selectedDateOfBirth = ''.obs;
  var isLoading = false.obs;

  /// TEXT CONTROLLERS
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final citizenshipController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countryController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final landlineController = TextEditingController();

  /// GENDER OPTIONS
  final genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    citizenshipController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    mobileNumberController.dispose();
    landlineController.dispose();
    super.onClose();
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1B5E3F),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1B5E3F),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Format: YYYY-MM-DD
      selectedDateOfBirth.value =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void submitPersonalInformation() {
    // validation
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        selectedGender.value.isEmpty ||
        selectedDateOfBirth.value.isEmpty ||
        citizenshipController.text.isEmpty ||
        streetAddressController.text.isEmpty ||
        cityController.text.isEmpty ||
        zipCodeController.text.isEmpty ||
        countryController.text.isEmpty ||
        mobileNumberController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
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
      // SUCCESS logic here
      Get.snackbar(
        'Success',
        'Profile Saved Locally',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // API HIT: POST personal information
      Get.to(() => const EducationView());
    });
  }

  void skipStep() {
    // Logic to skip or go next
    print("Skip Step");
  }
}
