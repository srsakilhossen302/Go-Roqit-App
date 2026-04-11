import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import '../../model/profile_model.dart';

class ProfilePortfolioController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  RxList<Portfolio> get portfolioItems => 
    (_profileController.userData.value?.profile?.portfolio ?? <Portfolio>[]).obs;

  void refreshData() {
    _profileController.fetchProfile();
  }
}
