class EducationModel {
  String degree;
  String institution;
  String fieldOfStudy;
  String type; // Diploma, Certificate, Bachelors etc
  String cgpa;
  String year;
  String duration;

  EducationModel({
    required this.degree,
    required this.institution,
    required this.fieldOfStudy,
    required this.type,
    required this.cgpa,
    required this.year,
    required this.duration,
  });
}
