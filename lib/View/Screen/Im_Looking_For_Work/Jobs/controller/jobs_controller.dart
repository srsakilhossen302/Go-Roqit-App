import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

class JobsController extends GetxController {
  var jobList = <JobModel>[].obs;
  var isLoadingLocation = true.obs;
  var isLoadingJobs = false.obs;
  
  var userLatitude = 23.8103.obs; // Default Dhaka
  var userLongitude = 90.4125.obs;

  // Search & Filter
  final searchController = TextEditingController();
  var selectedCategory = ''.obs;
  var selectedType = ''.obs;
  var selectedLocation = ''.obs;
  var minSalary = ''.obs;

  // Pagination
  var currentPage = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initLocationAndJobs();
  }

  Future<void> _initLocationAndJobs() async {
    try {
      Position position = await _determinePosition();
      userLatitude.value = position.latitude;
      userLongitude.value = position.longitude;
      loadJobs();
    } catch (e) {
      print("Location error: $e");
      loadJobs();
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> fetchJobs({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      hasMore.value = true;
      jobList.clear();
    }

    if (!hasMore.value || isLoadingJobs.value) return;

    isLoadingJobs.value = true;

    try {
      String queryString = "?page=${currentPage.value}&limit=10";

      if (searchController.text.isNotEmpty) {
        queryString += "&searchTerm=${Uri.encodeComponent(searchController.text)}";
      }
      if (selectedCategory.value.isNotEmpty) {
        queryString += "&category=${Uri.encodeComponent(selectedCategory.value)}";
      }
      if (selectedType.value.isNotEmpty) {
        queryString += "&type=${Uri.encodeComponent(selectedType.value)}";
      }
      if (selectedLocation.value.isNotEmpty) {
        queryString += "&jobLocation=${Uri.encodeComponent(selectedLocation.value)}";
      }
      if (minSalary.value.isNotEmpty) {
        queryString += "&minSalary=${Uri.encodeComponent(minSalary.value)}";
      }

      String finalUrl = ApiUrl.getJobs + queryString;
      final response = await Get.find<ApiClient>().getData(finalUrl);
      
      print("Fetch Jobs Status Code: ${response.statusCode}");
      print("Fetch Jobs Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null && data['data'] != null) {
          List jobsData = data['data'];
          List<JobModel> loadedJobs = jobsData.map((job) => JobModel.fromJson(job)).toList();
          
          if (isRefresh) {
            jobList.assignAll(loadedJobs);
          } else {
            jobList.addAll(loadedJobs);
          }

          if (loadedJobs.length < 10) {
            hasMore.value = false;
          } else {
            currentPage.value++;
          }
        }
      } else {
        Get.snackbar("Error", response.statusText ?? "Failed to fetch jobs");
      }
    } catch (e) {
      print("Error fetching jobs: $e");
      Get.snackbar("Error", "Connection failed. Please check your network.");
    } finally {
      isLoadingJobs.value = false;
    }
  }

  // Exposed wrapper for clean initial fetch
  void loadJobs() {
    fetchJobs(isRefresh: true);
  }

  void onChangeSearchTriggered(String value) {
     loadJobs();
  }
}
