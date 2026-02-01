class ApplicantModel {
  final String id;
  final String name;
  final String role;
  final String status; // 'new', 'reviewed', 'rejected'
  final String timeAgo;
  final String imageUrl;

  ApplicantModel({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
    required this.timeAgo,
    required this.imageUrl,
  });

  // Factory for API mapping
  factory ApplicantModel.fromJson(Map<String, dynamic> json) {
    return ApplicantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? 'new',
      timeAgo: json['time_ago'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}

class JobStatModel {
  final String roleName;
  final int count;
  final int totalCapacity; // For progress bar calculation

  JobStatModel({
    required this.roleName,
    required this.count,
    required this.totalCapacity,
  });
}
