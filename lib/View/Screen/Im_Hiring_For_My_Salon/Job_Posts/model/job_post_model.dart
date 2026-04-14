class JobPostModel {
  final String id;
  final String title;
  final String category;
  final String employmentType;
  final String engagementType;
  final String startDate;
  final String paymentType;
  final int minSalary;
  final int maxSalary;
  final String description;
  final String jobLocation;
  final int applicantCount;
  final String experienceLabel;
  final String createdAt;
  final String companyName;
  final String companyLogo;

  JobPostModel({
    required this.id,
    required this.title,
    required this.category,
    required this.employmentType,
    required this.engagementType,
    required this.startDate,
    required this.paymentType,
    required this.minSalary,
    required this.maxSalary,
    required this.description,
    required this.jobLocation,
    required this.applicantCount,
    required this.experienceLabel,
    required this.createdAt,
    required this.companyName,
    required this.companyLogo,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) {
    return JobPostModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      employmentType: json['type'] ?? '',
      engagementType: json['engagementType'] ?? '',
      startDate: json['startDate'] ?? '',
      paymentType: json['paymentType'] ?? '',
      minSalary: json['minSalary'] ?? 0,
      maxSalary: json['maxSalary'] ?? 0,
      description: json['description'] ?? '',
      jobLocation: json['jobLocation'] ?? '',
      applicantCount: json['applicationsCount'] ?? 0,
      experienceLabel: json['experianceLabel'] ?? '',
      createdAt: json['createdAt'] ?? '',
      companyName: json['user']?['profile']?['companyName'] ?? '',
      companyLogo: json['user']?['profile']?['companyLogo'] ?? '',
    );
  }
}
