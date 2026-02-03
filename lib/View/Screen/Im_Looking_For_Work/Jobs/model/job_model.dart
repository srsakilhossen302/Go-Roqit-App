class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String location;
  final String jobType;
  final String salary;
  final String logoUrl;
  final String postedTime;
  final String workingHours;
  final String workSystem;
  final List<String> skills;
  final String companyDescription;
  final List<String> businessPhotos;
  final List<String> requirements;
  final List<String> benefits;

  JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.logoUrl,
    required this.postedTime,
    required this.workingHours,
    required this.workSystem,
    required this.skills,
    required this.companyDescription,
    required this.businessPhotos,
    required this.requirements,
    required this.benefits,
  });
}
