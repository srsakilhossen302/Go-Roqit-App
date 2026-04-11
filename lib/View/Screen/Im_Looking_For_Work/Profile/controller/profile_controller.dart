import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/auth_screen.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/model/profile_model.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

class ProfileController extends GetxController {
  var isOpenToWork = true.obs;
  var isLoading = false.obs;
  var userData = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(
        SharedPreferenceValue.token,
      );

      final headers = {'Authorization': 'Bearer $token'};
      final response = await apiClient.getData(
        ApiUrl.getProfile,
        headers: headers,
      );

      if (response.statusCode == 200) {
        userData.value = ProfileModel.fromJson(response.body['data']);

        // Update isOpenToWork from API if available
        if (userData.value?.profile?.openToWork != null) {
          isOpenToWork.value = userData.value!.profile!.openToWork!;
        }
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to load profile',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleOpenToWork(bool value) async {
    isOpenToWork.value = value;
    // Optional: Call update API to persist this status
  }

  void logout() {
    Get.defaultDialog(
      title: "Log Out",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: "Are you sure you want to log out?",
      middleTextStyle: const TextStyle(fontSize: 14),
      backgroundColor: Colors.white,
      radius: 12,
      textCancel: "Cancel",
      textConfirm: "Log Out",
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF1B5E3F),
      onCancel: () {
        Get.back();
      },
      onConfirm: () async {
        // await SharePrefsHelper.remove(SharedPreferenceValue.token);
        // await SharePrefsHelper.remove(SharedPreferenceValue.role);
        Get.offAll(() => const AuthScreen());
      },
    );
  }
}
