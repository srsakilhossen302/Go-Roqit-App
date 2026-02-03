class AdditionalInformationModel {
  String resumeFileName;
  String resumeLastUpdated;
  String professionalSummary;
  List<String> skills;
  List<String> languages;
  List<String> workPreferences; // e.g., Full Time, Part Time
  String salaryExpectation;

  AdditionalInformationModel({
    required this.resumeFileName,
    required this.resumeLastUpdated,
    required this.professionalSummary,
    required this.skills,
    required this.languages,
    required this.workPreferences,
    required this.salaryExpectation,
  });
}
