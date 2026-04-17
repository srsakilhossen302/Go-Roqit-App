import 'package:geolocator/geolocator.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

class NearbyJobsController extends GetxController {
  var nearbyJobs = <JobModel>[].obs;
  var isLoadingLocation = true.obs;
  var isLoadingNearby = false.obs;

  var userLatitude = 23.8103.obs; // Default Dhaka
  var userLongitude = 90.4125.obs;

  @override
  void onInit() {
    super.onInit();
    initLocationAndFetch();
  }

  Future<void> initLocationAndFetch() async {
    isLoadingLocation.value = true;
    try {
      Position position = await _determinePosition();
      userLatitude.value = position.latitude;
      userLongitude.value = position.longitude;

      // Update user profile with current coordinates
      await updateUserLocation(position.latitude, position.longitude);

      await fetchJobsByDistance();
    } catch (e) {
      print("Nearby location error: $e");
      // Fallback or handle error
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

  Future<void> updateUserLocation(double lat, double lng) async {
    try {
      final response = await Get.find<ApiClient>().patchData(
        ApiUrl.updateProfile,
        {
          "coordinates": [lng, lat],
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User location updated successfully on profile (Nearby)");
      }
    } catch (e) {
      print("Error updating user location (Nearby): $e");
    }
  }

  Future<void> fetchJobsByDistance() async {
    isLoadingNearby.value = true;
    try {
      final response = await Get.find<ApiClient>().getData(ApiUrl.getJobsByDistance);
      
      print("Nearby API Response: ${response.statusCode}");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null && data['data'] != null) {
          List jobsData = data['data'];
          List<JobModel> loadedJobs = jobsData
              .map((job) => JobModel.fromJson(job))
              .toList();
          
          nearbyJobs.assignAll(loadedJobs);
          print("Loaded ${nearbyJobs.length} nearby jobs");
        }
      }
    } catch (e) {
      print("Error fetching nearby jobs: $e");
    } finally {
      isLoadingNearby.value = false;
    }
  }
}
