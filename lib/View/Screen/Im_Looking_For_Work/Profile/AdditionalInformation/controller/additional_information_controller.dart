import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/AdditionalInformation/model/additional_information_model.dart';

class ProfileAdditionalInformationController extends GetxController {
  final additionalInfoModel = AdditionalInformationModel(
    resumeFileName: "Resume.pdf",
    resumeLastUpdated: "Jan 2024",
    professionalSummary:
        "Passionate hair stylist with 8+ years of experience specializing in balayage, color correction, and creative styling. I love making clients feel confident and beautiful. Committed to staying updated with the latest trends and techniques.",
    skills: [
      "Balayage",
      "Color Correction",
      "Cutting",
      "Styling",
      "Hair Extensions",
      "Keratin Treatment",
    ],
    languages: ["English", "Spanish"],
    workPreferences: ["Full Time", "Part Time"],
    salaryExpectation: "£28,000 - £35,000 per year",
  ).obs;

  void updateSummary(String newSummary) {
    additionalInfoModel.value.professionalSummary = newSummary;
    additionalInfoModel.refresh();
  }

  void updateSkills(List<String> newSkills) {
    additionalInfoModel.value.skills = newSkills;
    additionalInfoModel.refresh();
  }

  void updateLanguages(List<String> newLanguages) {
    additionalInfoModel.value.languages = newLanguages;
    additionalInfoModel.refresh();
  }

  void updateWorkPreferences(List<String> preferences, String salary) {
    additionalInfoModel.value.workPreferences = preferences;
    additionalInfoModel.value.salaryExpectation = salary;
    additionalInfoModel.refresh();
  }

  // Placeholder for Resume actions
  void viewResume() {
    // Implement logic to view resume
    print("View Resume");
  }

  void updateResume() {
    // Implement logic to pick/upload new resume
    print("Update Resume");
  }
}
