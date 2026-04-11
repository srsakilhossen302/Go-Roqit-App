import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  var searchText = "".obs;
  var isLoading = false.obs;
  var jobList = <JobModel>[].obs;
  
  var userName = "Sarah".obs; // Default
  var userImage = "https://i.pravatar.cc/150?u=a042581f4e29026024d".obs; // Default

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchJobs();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await Get.find<ApiClient>().getData(ApiUrl.getProfile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null) {
          userName.value = data['name'] ?? "User";
          if (data['image'] != null && data['image'].toString().isNotEmpty) {
             userImage.value = "https://api.goroqit.com${data['image']}";
          }
        }
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  Future<void> fetchJobs({String searchTerm = ""}) async {
    isLoading.value = true;
    try {
      String url = "${ApiUrl.getJobs}?limit=5";
      if (searchTerm.isNotEmpty) {
        url += "&searchTerm=${Uri.encodeComponent(searchTerm)}";
      }
      
      final response = await Get.find<ApiClient>().getData(url);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null && data['data'] != null) {
          List jobsData = data['data'];
          jobList.assignAll(jobsData.map((job) => JobModel.fromJson(job)).toList());
        }
      } else {
        print("Error fetching jobs: ${response.statusText}");
      }
    } catch (e) {
      print("Exception fetching jobs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    // We could add a debounce here if needed
    fetchJobs(searchTerm: value);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
