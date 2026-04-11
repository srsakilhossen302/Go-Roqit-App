import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:get_x/get_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/model/user_information_model.dart';
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

  /// IMAGE
  final ImagePicker _picker = ImagePicker();
  var profileImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Check for arguments passed for editing
    if (Get.arguments != null && Get.arguments is UserInformationModel) {
      final UserInformationModel model = Get.arguments;
      firstNameController.text = model.firstName;
      lastNameController.text = model.lastName;
      selectedGender.value = model.gender;
      selectedDateOfBirth.value = model.dateOfBirth;
      citizenshipController.text = model.citizenship;
      streetAddressController.text = model.streetAddress;
      cityController.text = model.city;
      zipCodeController.text = model.zipCode;
      countryController.text = model.country;
      mobileNumberController.text = model.mobileNumber;
      landlineController.text = model.landline;
      profileImagePath.value = model.profileImagePath;
    }
  }

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

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        profileImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
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

  void submitPersonalInformation() async {
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

    try {
      final apiClient = Get.find<ApiClient>();
      final token =
          await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final dataBody = {
        "firstName": "${firstNameController.text} ${lastNameController.text}",
        "gender": selectedGender.value,
        "dateOfBirth": selectedDateOfBirth.value,
        "citizenship": citizenshipController.text,
        "streetAddress": streetAddressController.text,
        "city": cityController.text,
        "zipCode": zipCodeController.text,
        "country": countryController.text,
        "mobile": mobileNumberController.text,
        "landLine": landlineController.text,
      };

      final Map<String, dynamic> formDataMap = {
        "data": jsonEncode(dataBody),
      };

      // Handle Profile Image
      if (profileImagePath.value.isNotEmpty &&
          !profileImagePath.value.startsWith('http')) {
        final file = File(profileImagePath.value);
        if (await file.exists()) {
          formDataMap["image"] = MultipartFile(
            await file.readAsBytes(),
            filename: profileImagePath.value.split('/').last,
            contentType: 'image/jpeg',
          );
        }
      }

      final body = FormData(formDataMap);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(ApiUrl.updateProfile, body,
          headers: headers);

      print("Personal Info Response Status: ${response.statusCode}");
      print("Personal Info Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        if (Get.arguments != null && Get.arguments is UserInformationModel) {
          Get.back();
        } else {
          Get.to(() => const EducationView());
        }
      } else {
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

  void skipStep() {
    // Logic to skip or go next
    print("Skip Step");
  }
}
