import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/WorkExperience/model/work_experience_model.dart';

class ProfileWorkExperienceController extends GetxController {
  final workExperiences = <WorkExperienceModel>[
    WorkExperienceModel(
      jobTitle: "Senior Hair Stylist",
      companyName: "Glow Beauty Salon",
      location: "London, UK",
      startDate: "Jun 2018",
      endDate: "Present",
      duration: "5 years",
      employmentType: "Full Time",
      isCurrentPosition: true,
    ),
    WorkExperienceModel(
      jobTitle: "Junior Stylist",
      companyName: "Bella Hair Studio",
      location: "London, UK",
      startDate: "Sept 2015",
      endDate: "May 2018",
      duration: "3 years",
      employmentType: "Full Time",
      isCurrentPosition: false,
    ),
  ].obs;

  void addWorkExperience(WorkExperienceModel experience) {
    workExperiences.add(experience);
    workExperiences.refresh();
  }

  // Method to remove or edit can be added later
}
