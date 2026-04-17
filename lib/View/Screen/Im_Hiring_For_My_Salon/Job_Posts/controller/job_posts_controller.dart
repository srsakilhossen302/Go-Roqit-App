import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    isLoading.value = true;
    try {
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};
      
      final response = await Get.find<ApiClient>().getData("/job/$id", headers: headers);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jobData = response.body['data'];
        final job = JobPostModel.fromJson(jobData);
        isLoading.value = false;
        await Get.to(() => const PostJobView(), arguments: job);
        await loadJobPosts(); // Refresh list after returning
      } else {
        Get.snackbar('Error', 'Failed to fetch job details');
      }
    } catch (e) {
      print("Error fetching job details: $e");
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJob(String id) async {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete_outline, color: Colors.red, size: 32.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              "Delete Job Post?",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Are you sure you want to remove this job post? This action cannot be undone.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: const Color(0xFF4B5563), fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.back(); // Close bottom sheet
                      try {
                        final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
                        final headers = {'Authorization': 'Bearer $token'};
                        final response = await Get.find<ApiClient>().deleteData("/job/$id", headers: headers);
                        if (response.statusCode == 200 || response.statusCode == 201) {
                          activeJobPosts.removeWhere((job) => job.id == id);
                          Get.snackbar('Success', 'Job post removed', backgroundColor: Colors.green, colorText: Colors.white);
                        } else {
                          Get.snackbar('Error', 'Failed to delete job', backgroundColor: Colors.red, colorText: Colors.white);
                        }
                      } catch (e) {
                        Get.snackbar('Error', 'Connection failed', backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> refreshJobs() async {
    await loadJobPosts();
  }
}
