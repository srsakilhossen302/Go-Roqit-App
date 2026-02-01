class JobPostModel {
  final String id;
  final String title;
  final String employmentType; // Full-time, Part-time, etc.
  final String location;
  final String salaryRange;
  final String postedTime;
  final int applicantCount;

  final String status; // 'Open', 'Closed'
  final String description;
  final List<String> requirements;

  JobPostModel({
    required this.id,
    required this.title,
    required this.employmentType,
    required this.location,
    required this.salaryRange,
    required this.postedTime,
    required this.applicantCount,
    this.status = 'Open',
    this.description = '',
    this.requirements = const [],
  });
}
