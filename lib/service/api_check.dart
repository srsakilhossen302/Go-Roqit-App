import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/auth_screen.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      SharePrefsHelper.remove(SharedPreferenceValue.token);
      SharePrefsHelper.remove(SharedPreferenceValue.role);
      Get.offAll(() => const AuthScreen());
    } else {
      Get.snackbar(
        "Error",
        response.statusText ?? "Something went wrong",
        snackPosition: SnackPosition.bottom,
      );
    }
  }
}
