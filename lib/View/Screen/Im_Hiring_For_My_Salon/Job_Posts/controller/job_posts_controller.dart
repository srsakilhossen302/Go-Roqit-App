import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/job_post_model.dart';
import '../../Job_Details/view/job_details_view.dart';
import '../../Post_Job/view/post_job_view.dart';

class JobPostsController extends GetxController {
  var activeJobPosts = <JobPostModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadJobPosts();
  }

  Future<void> loadJobPosts() async {
    isLoading.value = true;
    try {
      final token = await SharePrefsHelper.getString(
        SharedPreferenceValue.token,
      );
      final headers = {'Authorization': 'Bearer $token'};
      final response = await Get.find<ApiClient>().getData(
        ApiUrl.myJobs,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List jobsData = response.body['data']['data'] ?? [];
        activeJobPosts.value = jobsData
            .map((json) => JobPostModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar('Error', response.statusText ?? 'Failed to load jobs');
      }
    } catch (e) {
      print("Error loading my jobs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void viewDetails(String id) {
    final job = activeJobPosts.firstWhere((j) => j.id == id);
    Get.to(() => const JobDetailsView(), arguments: job);
  }

  Future<void> editJob(String id) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};
      
      final response = await Get.find<ApiClient>().getData("/job/$id", headers: headers);
      
      if (Get.isDialogOpen ?? false) Get.back(); // close dialog
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jobData = response.body['data'];
        final job = JobPostModel.fromJson(jobData);
        await Get.to(() => const PostJobView(), arguments: job);
        loadJobPosts(); // Refresh list after returning
      } else {
        Get.snackbar('Error', 'Failed to fetch job details');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      print("Error fetching job details: $e");
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<void> deleteJob(String id) async {
    Get.defaultDialog(
      title: "Delete Job",
      middleText: "Are you sure you want to delete this job post?",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        // Close the dialog first
        if (Get.isOverlaysOpen) {
          Get.back();
        }

        try {
          final token = await SharePrefsHelper.getString(
            SharedPreferenceValue.token,
          );
          final headers = {'Authorization': 'Bearer $token'};

          final response = await Get.find<ApiClient>().deleteData(
            "/job/$id",
            headers: headers,
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            activeJobPosts.removeWhere((job) => job.id == id);
            Get.snackbar('Success', 'Job post removed');
          } else {
            Get.snackbar('Error', 'Failed to delete job');
          }
        } catch (e) {
          Get.snackbar('Error', 'Connection failed');
        }
      },
    );
  }

  Future<void> refreshJobs() async {
    await loadJobPosts();
  }
}
