import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Education/model/education_model.dart';

class ProfileEducationController extends GetxController {
  final educationList = <EducationModel>[
    EducationModel(
      degree: "Level 3 Diploma in Hairdressing",
      institution: "London College of Beauty Therapy",
      fieldOfStudy: "Hair & Beauty",
      type: "Diploma",
      cgpa: "CGPA: 4.0/4.0",
      year: "2015",
      duration: "2 years",
    ),
    EducationModel(
      degree: "Advanced Color Techniques",
      institution: "Vidal Sassoon Academy",
      fieldOfStudy: "Balayage & Color Correction",
      type: "Certificate",
      cgpa: "CGPA: 3.8/4.0",
      year: "2017",
      duration: "6 months",
    ),
  ].obs;

  void addEducation(EducationModel education) {
    educationList.add(education);
    educationList.refresh();
  }
}
