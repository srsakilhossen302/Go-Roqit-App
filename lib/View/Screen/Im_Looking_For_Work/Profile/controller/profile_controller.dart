import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/auth_screen.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';

class ProfileController extends GetxController {
  var isOpenToWork = true.obs;

  void toggleOpenToWork(bool value) {
    isOpenToWork.value = value;
    // Call API to update status if needed
  }

  Future<void> logout() async {
    // Clear session data
    await SharePrefsHelper.remove(SharedPreferenceValue.token);
    await SharePrefsHelper.remove(SharedPreferenceValue.role);
    // Add other keys if necessary

    // Navigate to Auth Screen
    Get.offAll(() => const AuthScreen());
  }
}
