import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:go_roqit_app/Utils/Toast/toast.dart';

class JobDetailsController extends GetxController {
  var isLoading = false.obs;
  var detailedJob = Rxn<JobModel>();

  Future<void> fetchSingleJob(String jobId) async {
    isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().getData(
        "${ApiUrl.getJobs}/$jobId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null) {
          detailedJob.value = JobModel.fromJson(data);
        }
      }
    } catch (e) {
      print("Error fetching single job: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyToJob(String jobId) async {
    isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().postData(ApiUrl.applyJob, {
        "job": jobId,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastHelper.success("Application submitted successfully! 🚀");
      } else {
        // Technical errors map to friendly messages
        String message = response.body['message'] ?? "";
        if (message.toLowerCase().contains("token not found")) {
          ToastHelper.error("Please log in to apply for this job.");
        } else if (response.statusCode == 401) {
          ToastHelper.error("Your session has expired. Please log in again.");
        } else {
          ToastHelper.error("Something went wrong. Please try again later.");
        }
      }
    } catch (e) {
      print("Error applying to job: $e");
      ToastHelper.error("Connection failed. Please check your network.");
    } finally {
      isLoading.value = false;
    }
  }
}
