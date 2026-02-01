import 'package:get_x/get.dart';
import '../model/job_post_model.dart';

class JobPostsController extends GetxController {
  var activeJobPosts = <JobPostModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadJobPosts();
  }

  void loadJobPosts() {
    isLoading.value = true;

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      activeJobPosts.value = [
        JobPostModel(
          id: '1',
          title: 'Senior Hair Stylist',
          employmentType: 'Full-time',
          location: 'Kensington, London',
          salaryRange: '£28,000 - £35,000/year',
          postedTime: '2d ago',
          applicantCount: 12,
          description:
              'We are looking for a talented Senior Hair Stylist to join our team.',
          requirements: ['Total 5 years experience', 'NVQ Level 3'],
        ),
        JobPostModel(
          id: '2',
          title: 'Master Barber',
          employmentType: 'Full-time',
          location: 'Shoreditch, London',
          salaryRange: '£25,000 - £30,000/year',
          postedTime: '5d ago',
          applicantCount: 8,
          status: 'Open',
          description:
              'We are seeking an experienced Master Barber to join our team. The ideal candidate will have strong skills in their field and a passion for beauty services.',
          requirements: [
            'Minimum 3 years of experience',
            'Professional certification required',
            'Excellent customer service skills',
          ],
        ),
        JobPostModel(
          id: '3',
          title: 'Nail Technician',
          employmentType: 'Part-time',
          location: 'Manchester City Centre',
          salaryRange: '£22,000 - £26,000/year (pro-rata)',
          postedTime: '1d ago',
          applicantCount: 15,
        ),
        JobPostModel(
          id: '4',
          title: 'Lead Makeup Artist',
          employmentType: 'Full-time',
          location: 'Birmingham',
          salaryRange: '£35,000 - £45,000/year',
          postedTime: '7d ago',
          applicantCount: 6,
        ),
        JobPostModel(
          id: '5',
          title: 'Beauty Therapist',
          employmentType: 'Full-time',
          location: 'Leeds',
          salaryRange: '£23,000 - £28,000/year',
          postedTime: '3d ago',
          applicantCount: 9,
        ),
      ];
      isLoading.value = false;
    });
  }

  void showJobOptions(JobPostModel job) {
    // Show Popup Menu or Bottom Sheet
    // Using simple options logging for now, View will handle the visual popup.
  }

  void viewDetails(String id) {
    Get.snackbar('Action', 'View Details for $id');
  }

  void editJob(String id) {
    Get.snackbar('Action', 'Edit Job $id');
  }

  void deleteJob(String id) {
    activeJobPosts.removeWhere((job) => job.id == id);
    Get.snackbar('Deleted', 'Job post removed');
  }
}
