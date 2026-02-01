class JobPostModel {
  final String id;
  final String title;
  final String roleType; // Barber, Stylist, etc.
  final String employmentType; // Full-time, Part-time, etc.
  final String location;
  final String salaryRange;
  final String postedTime;
  final int applicantCount;

  final String status; // 'Open', 'Closed'
  final String description;
  final List<String> requirements;

  final String minSalary;
  final String maxSalary;
  final String salaryType; // per year, per hour
  final String benefits;
  final String workSchedule;

  JobPostModel({
    required this.id,
    required this.title,
    required this.roleType,
    required this.employmentType,
    required this.location,
    required this.salaryRange,
    required this.postedTime,
    required this.applicantCount,
    this.status = 'Open',
    this.description = '',
    this.requirements = const [],
    this.minSalary = '',
    this.maxSalary = '',
    this.salaryType = 'per year',
    this.benefits = '',
    this.workSchedule = '',
  });
}
