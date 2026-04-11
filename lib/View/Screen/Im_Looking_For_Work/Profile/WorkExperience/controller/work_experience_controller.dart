import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import '../../model/profile_model.dart';

class ProfileWorkExperienceController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  RxList<WorkExperience> get workExperiences => 
    (_profileController.userData.value?.profile?.workExperience ?? <WorkExperience>[]).obs;

  void refreshData() {
    _profileController.fetchProfile();
  }
}
