import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import '../model/additional_information_model.dart';

class ProfileAdditionalInformationController extends GetxController {
  final ProfileController _profileController = Get.find<ProfileController>();

  late Rx<AdditionalInformationModel> additionalInfoModel;

  @override
  void onInit() {
    super.onInit();
    _updateModel();
  }

  void _updateModel() {
    final profile = _profileController.userData.value?.profile;
    
    additionalInfoModel = AdditionalInformationModel(
      resumeFileName: "Resume.pdf", // Backend doesn't provide file name directly
      resumeLastUpdated: profile?.updatedAt?.split('T').first ?? "Not set",
      professionalSummary: "", // Not found in JSON
      skills: profile?.skills ?? [],
      languages: profile?.languages ?? [],
      workPreferences: [], // Not found in JSON
      salaryExpectation: "Not set", // Not found in JSON
    ).obs;
  }

  void refreshData() {
    _profileController.fetchProfile().then((_) => _updateModel());
  }

  void updateSummary(String text) {
    additionalInfoModel.value.professionalSummary = text;
    additionalInfoModel.refresh();
  }

  void updateSkills(List<String> skills) {
    additionalInfoModel.value.skills = skills;
    additionalInfoModel.refresh();
  }

  void updateLanguages(List<String> languages) {
    additionalInfoModel.value.languages = languages;
    additionalInfoModel.refresh();
  }

  void updateWorkPreferences(List<String> prefs, String salary) {
    additionalInfoModel.value.workPreferences = prefs;
    additionalInfoModel.value.salaryExpectation = salary;
    additionalInfoModel.refresh();
  }

  void updateResume() {
    // Logic to update resume (e.g., File Picker)
  }

  void viewResume() {
    // Logic to view resume (e.g., Open PDF)
  }
}
