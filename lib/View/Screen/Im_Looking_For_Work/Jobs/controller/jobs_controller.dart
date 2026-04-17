import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import 'package:go_roqit_app/Utils/Toast/toast.dart';
import 'package:go_roqit_app/View/Screen/Im_Hiring_For_My_Salon/Post_Job/model/category_model.dart';

class JobsController extends GetxController {
  var jobList = <JobModel>[].obs;
  var isLoadingLocation = true.obs;
  var isLoadingJobs = false.obs;
  
  var categoryList = <CategoryModel>[].obs;
  var isCategoryLoading = false.obs;

  var userLatitude = 0.0.obs; // Default Dhaka
  var userLongitude = 0.0.obs;

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
    fetchCategories();
  }

  Future<void> _initLocationAndJobs() async {
    try {
      Position position = await _determinePosition();
      userLatitude.value = position.latitude;
      userLongitude.value = position.longitude;

      // Update user profile with current coordinates
      await updateUserLocation(position.latitude, position.longitude);
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
        queryString +=
            "&searchTerm=${Uri.encodeComponent(searchController.text)}";
      }
      if (selectedCategory.value.isNotEmpty) {
        queryString +=
            "&category=${Uri.encodeComponent(selectedCategory.value)}";
      }
      if (selectedType.value.isNotEmpty) {
        queryString += "&type=${Uri.encodeComponent(selectedType.value)}";
      }
      if (selectedLocation.value.isNotEmpty) {
        queryString +=
            "&jobLocation=${Uri.encodeComponent(selectedLocation.value)}";
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
          List<JobModel> loadedJobs = jobsData
              .map((job) => JobModel.fromJson(job))
              .toList();

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

  var isApplying = false.obs;

  Future<void> applyToJob(String jobId) async {
    isApplying.value = true;
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
      isApplying.value = false;
    }
  }

  void onChangeSearchTriggered(String value) {
    loadJobs();
  }

  Future<void> createChat(String recruiterId) async {
    if (recruiterId.isEmpty) {
      ToastHelper.error("Recruiter information not available.");
      return;
    }

    try {
      final response = await Get.find<ApiClient>().postData(ApiUrl.createChat, {
        "participants": [recruiterId],
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastHelper.success("Chat initiated! 💬");
      } else {
        ToastHelper.error("Failed to start chat.");
      }
    } catch (e) {
      print("Error creating chat: $e");
      ToastHelper.error("Connection failed.");
    }
  }

  Future<void> updateUserLocation(double lat, double lng) async {
    try {
      final response = await Get.find<ApiClient>().patchData(
        ApiUrl.updateProfile,
        {
          "coordinates": [lng, lat],
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User location updated successfully on profile");
      } else {
        print("Failed to update user location: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating user location: $e");
    }
  }

  Future<void> fetchCategories() async {
    isCategoryLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().getData(ApiUrl.getCategories);
      if (response.statusCode == 200 && response.body['data'] != null) {
        final List<dynamic> data = response.body['data']['data'] ?? [];
        categoryList.assignAll(data.map((json) => CategoryModel.fromJson(json)).toList());
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isCategoryLoading.value = false;
    }
  }
}
