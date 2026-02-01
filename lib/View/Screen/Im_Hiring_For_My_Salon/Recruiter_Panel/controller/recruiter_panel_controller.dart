import 'package:get_x/get.dart';
import '../model/recruiter_models.dart';

class RecruiterPanelController extends GetxController {
  // Dashboard Stats
  var totalJobs = 12.obs;
  var applicants = 248.obs;
  var applicantTrend = 12.obs; // +12%

  // Lists
  var recentApplications = <ApplicantModel>[].obs;
  var topPerformingJobs = <JobStatModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void fetchDashboardData() {
    isLoading.value = true;

    // Simulate API Call
    Future.delayed(const Duration(seconds: 1), () {
      // Mock Data: Recent Applications
      recentApplications.value = [
        ApplicantModel(
          id: '1',
          name: 'Sarah Mitchell',
          role: 'Senior Hair Stylist',
          status: 'new',
          timeAgo: '2h ago',
          imageUrl: 'https://i.pravatar.cc/150?u=1', // Placeholder
        ),
        ApplicantModel(
          id: '2',
          name: 'Marcus Thompson',
          role: 'Barber',
          status: 'new',
          timeAgo: '5h ago',
          imageUrl: 'https://i.pravatar.cc/150?u=2',
        ),
        ApplicantModel(
          id: '3',
          name: 'Emily Chen',
          role: 'Nail Technician',
          status: 'reviewed',
          timeAgo: '1d ago',
          imageUrl: 'https://i.pravatar.cc/150?u=3',
        ),
      ];

      // Mock Data: Top Performing Jobs
      topPerformingJobs.value = [
        JobStatModel(
          roleName: 'Senior Hair Stylist',
          count: 42,
          totalCapacity: 50,
        ),
        JobStatModel(
          roleName: 'Experienced Barber',
          count: 38,
          totalCapacity: 50,
        ),
        JobStatModel(roleName: 'Nail Technician', count: 31, totalCapacity: 50),
      ];

      isLoading.value = false;
    });
  }
}
