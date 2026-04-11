import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/model/user_information_model.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:go_roqit_app/service/api_client.dart';

class UserInformationController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  late Rx<UserInformationModel> userModel;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _updateModel();
  }

  void refreshData() {
    _profileController.fetchProfile().then((_) => _updateModel());
  }

  void _updateModel() {
    final profile = _profileController.userData.value?.profile;
    final user = _profileController.userData.value;
    
    userModel = UserInformationModel(
      firstName: profile?.firstName ?? user?.name?.split(' ').first ?? "",
      lastName: user?.name?.split(' ').length == 2 ? user?.name?.split(' ').last ?? "" : "",
      gender: profile?.gender ?? "",
      dateOfBirth: profile?.dateOfBirth?.split('T').first ?? "",
      citizenship: profile?.citizenship ?? "",
      streetAddress: profile?.streetAddress ?? "",
      city: profile?.city ?? "",
      zipCode: profile?.zipCode ?? "",
      country: profile?.country ?? "",
      mobileNumber: profile?.mobile ?? "",
      landline: profile?.landLine ?? "",
      profileImagePath: user?.image ?? "",
    ).obs;
  }

  Future<void> updateBasicInfo(
    String firstName,
    String lastName,
    String gender,
    String dob,
    String citizenship,
  ) async {
    final Map<String, dynamic> data = {
      "firstName": firstName,
      // Backend model may not use lastName, but we combine it if needed
      "gender": gender,
      "dateOfBirth": dob,
      "citizenship": citizenship,
    };
    await _updateProfile(data);
  }

  Future<void> updateAddress(String street, String city, String zip, String country) async {
    final Map<String, dynamic> data = {
      "streetAddress": street,
      "city": city,
      "zipCode": zip,
      "country": country,
    };
    await _updateProfile(data);
  }

  Future<void> updateContact(String mobile, String landline) async {
    final Map<String, dynamic> data = {
      "mobile": mobile,
      "landLine": landline,
    };
    await _updateProfile(data);
  }

  Future<void> _updateProfile(Map<String, dynamic> payload) async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);

      final body = FormData({
        "data": jsonEncode(payload),
      });

      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.patchData(ApiUrl.updateProfile, body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Details updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        refreshData();
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to update details',
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
}
