import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  var isSignIn = true.obs;
//kjsdkflss
  void switchTab(bool value) {
    isSignIn.value = value;
  }
}
