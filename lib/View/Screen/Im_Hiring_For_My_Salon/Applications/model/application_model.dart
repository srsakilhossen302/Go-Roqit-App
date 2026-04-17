class ApplicationModel {
  final String id;
  final String name;
  final String role;
  final String status;
  final String location;
  final String date;
  final List<String> skills;
  final bool hasUnreadMessage;
  final String imageUrl;
  final String email;
  final String phone;
  final String resume;
  final String jobId;
  final String applicantId;

  // detailed info
  final String experienceYears;
  final String about;
  final List<WorkExperience> workExperience;
  final List<Education> education;
  final List<String> languages;
  final List<PortfolioItem> portfolio;
  final String salaryExpectation;
  final String availability;
  final String resumeObj; 
  final String additionalNotes;

  ApplicationModel({
    required this.id,
    required this.name,
    required this.role,
    this.status = 'Pending',
    required this.location,
    required this.date,
    this.skills = const [],
    this.hasUnreadMessage = false,
    this.imageUrl = '',
    this.email = '',
    this.phone = '',
    this.resume = '',
    this.jobId = '',
    this.applicantId = '',
    this.experienceYears = '',
    this.about = '',
    this.workExperience = const [],
    this.education = const [],
    this.languages = const [],
    this.portfolio = const [],
    this.salaryExpectation = '',
    this.availability = '',
    this.resumeObj = '',
    this.additionalNotes = '',
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    String resumePath = json['resume'] ?? '';
    String resumeName = resumePath.split('/').last;

    return ApplicationModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['job']?['title'] ?? json['title'] ?? '',
      status: json['status'] ?? 'Pending',
      location: json['location'] ?? '',
      date: json['createdAt'] != null 
          ? _formatDate(json['createdAt']) 
          : '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      resume: resumePath,
      resumeObj: resumeName.isNotEmpty ? resumeName : 'Resume.pdf',
      jobId: json['job']?['_id'] ?? '',
      applicantId: json['applicant'] is Map ? (json['applicant']['_id'] ?? '') : (json['applicant']?.toString() ?? ''),
      imageUrl: json['imageUrl'] ?? 'https://i.pravatar.cc/300?img=5',
      skills: [''], // Default for now
      experienceYears: '', // Default for now
      about: 'No description provided.', // Default for now
      workExperience: [],
      education: [],
      languages: [''],
      portfolio: [],
      salaryExpectation: '',
      availability: '',
      additionalNotes: '',
    );
  }

  static String _formatDate(String dateStr) {
    try {
      DateTime dt = DateTime.parse(dateStr);
      return "${dt.day} ${_getMonth(dt.month)}";
    } catch (e) {
      return dateStr;
    }
  }

  static String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}

// Keeping these for potential detailed view use, though they might need updating too
class WorkExperience {
  final String role;
  final String company;
  final String dateRange;
  final String type;
  final String location;

  WorkExperience({
    required this.role,
    required this.company,
    required this.dateRange,
    required this.type,
    required this.location,
  });
}

class Education {
  final String degree;
  final String school;
  final String year;

  Education({required this.degree, required this.school, required this.year});
}

class PortfolioItem {
  final String title;
  final String description;
  final List<String> images;

  PortfolioItem({
    required this.title,
    required this.description,
    required this.images,
  });
}
