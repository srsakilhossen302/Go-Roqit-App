class ProfileModel {
  String? id;
  String? email;
  String? status;
  bool? verified;
  String? role;
  String? name;
  String? image;
  ApplicantProfile? profile;
  String? roleProfile;
  int? profileCompletion;
  bool? subscribe;

  ProfileModel({
    this.id,
    this.email,
    this.status,
    this.verified,
    this.role,
    this.name,
    this.image,
    this.profile,
    this.roleProfile,
    this.profileCompletion,
    this.subscribe,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      email: json['email'],
      status: json['status'],
      verified: json['verified'],
      role: json['role'],
      name: json['name'],
      image: json['image'],
      profile: json['profile'] != null
          ? ApplicantProfile.fromJson(json['profile'])
          : null,
      roleProfile: json['roleProfile'],
      profileCompletion: json['profileCompletion'],
      subscribe: json['subscribe'],
    );
  }
}

class ApplicantProfile {
  String? id;
  String? userId;
  List<String>? skills;
  List<String>? languages;
  bool? openToWork;
  String? firstName;
  List<Education>? education;
  List<WorkExperience>? workExperience;
  List<Portfolio>? portfolio;
  String? citizenship;
  String? city;
  String? country;
  String? dateOfBirth;
  String? gender;
  String? landLine;
  String? mobile;
  String? streetAddress;
  String? zipCode;
  String? resume;
  String? updatedAt;

  ApplicantProfile({
    this.id,
    this.userId,
    this.skills,
    this.languages,
    this.openToWork,
    this.firstName,
    this.education,
    this.workExperience,
    this.portfolio,
    this.citizenship,
    this.city,
    this.country,
    this.dateOfBirth,
    this.gender,
    this.landLine,
    this.mobile,
    this.streetAddress,
    this.zipCode,
    this.resume,
    this.updatedAt,
  });

  factory ApplicantProfile.fromJson(Map<String, dynamic> json) {
    return ApplicantProfile(
      id: json['_id'],
      userId: json['userId'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
      languages:
          json['languages'] != null ? List<String>.from(json['languages']) : [],
      openToWork: json['openToWork'] ?? false,
      firstName: json['firstName'],
      education: json['education'] != null
          ? (json['education'] as List)
              .map((e) => Education.fromJson(e))
              .toList()
          : [],
      workExperience: json['workExperience'] != null
          ? (json['workExperience'] as List)
              .map((e) => WorkExperience.fromJson(e))
              .toList()
          : [],
      portfolio: json['portfolio'] != null
          ? (json['portfolio'] as List)
              .map((e) => Portfolio.fromJson(e))
              .toList()
          : [],
      citizenship: json['citizenship'],
      city: json['city'],
      country: json['country'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      landLine: json['landLine'],
      mobile: json['mobile'],
      streetAddress: json['streetAddress'],
      zipCode: json['zipCode'],
      resume: json['resume'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Education {
  String? degreeTitle;
  String? instituteName;
  String? major;
  String? duration;
  String? yearOfPassing;
  String? description;
  List<String>? certificate;

  Education({
    this.degreeTitle,
    this.instituteName,
    this.major,
    this.duration,
    this.yearOfPassing,
    this.description,
    this.certificate,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degreeTitle: json['degreeTitle'],
      instituteName: json['instituteName'],
      major: json['major'],
      duration: json['duration'],
      yearOfPassing: json['yearOfPassing'],
      description: json['description'],
      certificate: json['certificate'] != null
          ? List<String>.from(json['certificate'])
          : [],
    );
  }
}

class WorkExperience {
  String? jobTitle;
  String? companyName;
  String? location;
  String? employmentType;
  String? startDate;
  String? endDate;
  String? experience;

  WorkExperience({
    this.jobTitle,
    this.companyName,
    this.location,
    this.employmentType,
    this.startDate,
    this.endDate,
    this.experience,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      location: json['location'],
      employmentType: json['employmentType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      experience: json['experience'],
    );
  }
}

class Portfolio {
  String? title;
  String? description;
  List<String>? portfolioImages;

  Portfolio({
    this.title,
    this.description,
    this.portfolioImages,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      title: json['title'],
      description: json['description'],
      portfolioImages: json['portfolioImages'] != null
          ? List<String>.from(json['portfolioImages'])
          : [],
    );
  }
}
