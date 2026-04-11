class AdditionalInformationModel {
  String resumeFileName;
  String resumeLastUpdated;
  String? resumeUrl;
  String professionalSummary;
  List<String> skills;
  List<String> languages;
  List<String> workPreferences; // e.g., Full Time, Part Time
  String salaryExpectation;

  AdditionalInformationModel({
    required this.resumeFileName,
    required this.resumeLastUpdated,
    this.resumeUrl,
    required this.professionalSummary,
    required this.skills,
    required this.languages,
    required this.workPreferences,
    required this.salaryExpectation,
  });
}
