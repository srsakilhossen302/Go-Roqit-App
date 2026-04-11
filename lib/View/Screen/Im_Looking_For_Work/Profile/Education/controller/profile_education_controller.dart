import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import '../../model/profile_model.dart';

class ProfileEducationController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  RxList<Education> get educationList => 
    (_profileController.userData.value?.profile?.education ?? <Education>[]).obs;

  void refreshData() {
    _profileController.fetchProfile();
  }
}
