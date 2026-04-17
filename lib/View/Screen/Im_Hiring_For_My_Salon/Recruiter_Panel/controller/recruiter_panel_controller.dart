import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/recruiter_models.dart';

class RecruiterPanelController extends GetxController {
  // Dashboard Stats
  var totalJobs = 0.obs;
  var applicants = 0.obs;
  var applicantTrend = 0.obs; // +12%

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
      final token = await SharePrefsHelper.getString(
        SharedPreferenceValue.token,
      );
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.getData(
        ApiUrl.getProfile,
        headers: headers,
      );

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

  Future<void> fetchDashboardData() async {
    isLoading.value = true;

    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};

      // Fetch from API
      final response = await apiClient.getData(ApiUrl.recruiterStatistics, headers: headers);
      if (response.statusCode == 200) {
        final resData = response.body['data'];

        totalJobs.value = resData['totalJobs'] ?? 0;
        applicants.value = resData['totalApplications'] ?? 0;

        if (resData['topJobs'] != null) {
          final topJobsList = resData['topJobs'] as List;
          topPerformingJobs.value = topJobsList.map((job) {
            return JobStatModel(
              roleName: job['title'] ?? 'Unknown',
              count: job['applicationsCount'] ?? 0,
              totalCapacity: 50, // Keep static for progress bar UI
            );
          }).toList();
        }
      }

      // Recent Applications (We can fetch from API if available or leave empty)
      recentApplications.value = [];
    } catch (e) {
      print("Error fetching recruiter dashboard data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    isLoading.value = true;
    fetchDashboardData();
  }
}
