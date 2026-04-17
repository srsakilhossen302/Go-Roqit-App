import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/recruiter_models.dart';


class RecruiterPanelController extends GetxController {
  // Dashboard Stats
  var totalJobs = 12.obs;
  var applicants = 248.obs;
  var applicantTrend = 12.obs; // +12%

  // Lists
  // Lists
  var recentApplications = <ApplicantModel>[].obs;
  var topPerformingJobs = <JobStatModel>[].obs;

  // Profile Info
  var userName = 'Loading...'.obs;
  var userImage = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileInfo();
    fetchDashboardData();
  }

  Future<void> fetchProfileInfo() async {
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.getData(ApiUrl.getProfile, headers: headers);

      if (response.statusCode == 200) {
        final resData = response.body['data'];

        userName.value = resData['name'] ?? 'User Name';
        
        String? imagePath = resData['image'];
        if (imagePath != null && imagePath.isNotEmpty) {
          userImage.value = imagePath.startsWith('http') 
              ? imagePath 
              : "${ApiUrl.IMGUrl}$imagePath";
        }
      }
    } catch (e) {
      print("Error fetching recruiter profile: $e");
    }
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

  Future<void> refreshDashboard() async {
    isLoading.value = true;
    // Simulate API Call
    await Future.delayed(const Duration(seconds: 1));
    fetchDashboardData();
  }
}
