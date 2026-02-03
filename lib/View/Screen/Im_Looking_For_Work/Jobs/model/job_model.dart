class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String location;
  final String jobType;
  final String salary;
  final String logoUrl;

  JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.logoUrl,
  });
}
