import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/recruiter_models.dart';
import 'package:flutter/material.dart';
import '../../Applications/model/application_model.dart';
import '../../Applications/view/application_details_view.dart';

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

      // Recent Applications
      final appResponse = await apiClient.getData(ApiUrl.applyJob, headers: headers);
      if (appResponse.statusCode == 200 && appResponse.body['data'] != null) {
        final List<dynamic> appData = appResponse.body['data']['data'] ?? [];
        
        recentApplications.value = appData.take(3).map((json) {
          String imgPath = json['resume'] ?? ''; 
          if (imgPath.isNotEmpty && !imgPath.startsWith('http')) {
            imgPath = "${ApiUrl.IMGUrl}$imgPath";
          } else if (imgPath.isEmpty) {
            imgPath = "https://ui-avatars.com/api/?name=${Uri.encodeComponent(json['name'] ?? 'User')}";
          }

          return ApplicantModel(
            id: json['_id'] ?? '',
            name: json['name'] ?? 'Applicant',
            role: json['job']?['title'] ?? 'Role',
            status: json['status'] ?? 'new',
            timeAgo: 'Recent',
            imageUrl: imgPath,
          );
        }).toList();
      } else {
        recentApplications.value = [];
      }
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

  Future<void> fetchApplicationDetails(String id) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};
      
      final response = await apiClient.getData('${ApiUrl.applyJob}/$id', headers: headers);
      
      if (Get.isDialogOpen ?? false) Get.back(); // close dialog
      
      if (response.statusCode == 200 && response.body['success'] == true) {
        final resData = response.body['data'];
        
        Map<String, dynamic> data = resData;
        if (data['applicant'] != null && data['applicant']['image'] != null) {
            String imgPath = data['applicant']['image'];
            data['imageUrl'] = imgPath.startsWith('http') ? imgPath : "${ApiUrl.IMGUrl}$imgPath";
        }
        
        final ApplicationModel appDetails = ApplicationModel.fromJson(data);
        
        Get.to(() => const ApplicationDetailsView(), arguments: appDetails);
      } else {
        Get.snackbar('Error', 'Failed to fetch application details');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back(); // close dialog if error
      print("Error fetching application details: $e");
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
