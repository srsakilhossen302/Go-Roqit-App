class WorkExperienceModel {
  String jobTitle;
  String companyName;
  String location;
  String startDate;
  String endDate;
  String duration;
  String employmentType; // Full Time, Part Time, etc.
  bool isCurrentPosition;

  WorkExperienceModel({
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.employmentType,
    this.isCurrentPosition = false,
  });
}
