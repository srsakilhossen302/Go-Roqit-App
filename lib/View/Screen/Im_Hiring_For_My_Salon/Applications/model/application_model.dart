class ApplicationModel {
  final String id;
  final String name;
  final String role;
  final String status; // 'Pending', 'Shortlisted', 'Hired'
  final String location;
  final String date;
  final List<String> skills;
  final bool hasUnreadMessage;
  final String imageUrl;

  // detailed info
  final String experienceYears;
  final String email;
  final String phone;
  final String about;
  final List<WorkExperience> workExperience;
  final List<Education> education;
  final List<String> languages;
  final List<PortfolioItem> portfolio;
  final String salaryExpectation;
  final String availability;
  final String resumeObj; // Name of resume file
  final String additionalNotes;

  ApplicationModel({
    required this.id,
    required this.name,
    required this.role,
    required this.status,
    required this.location,
    required this.date,
    required this.skills,
    this.hasUnreadMessage = false,
    required this.imageUrl,
    this.experienceYears = '',
    this.email = '',
    this.phone = '',
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
}

class WorkExperience {
  final String role;
  final String company;
  final String dateRange;
  final String type; // Full Time, etc.
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
