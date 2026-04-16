import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/application_model.dart';
import '../view/application_details_view.dart';

class ApplicationsController extends GetxController {
  var applications = <ApplicationModel>[].obs;
  var filteredApplications = <ApplicationModel>[].obs;
  var selectedFilter = 'All'.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadApplications();
  }

  Future<void> loadApplications() async {
    isLoading.value = true;
    try {
      final apiClient = Get.find<ApiClient>();
      final token = await SharePrefsHelper.getString(
        SharedPreferenceValue.token,
      );
      final headers = {'Authorization': 'Bearer $token'};

      final response = await apiClient.getData(
        ApiUrl.applyJob,
        headers: headers,
      );

      if (response.statusCode == 200 && response.body['data'] != null) {
        final List<dynamic> data = response.body['data']['data'] ?? [];
        final List<ApplicationModel> loadedApps = data
            .map((json) => ApplicationModel.fromJson(json))
            .toList();

        applications.assignAll(loadedApps);
        filterApplications(selectedFilter.value);
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to load applications',
        );
      }
    } catch (e) {
      print("Error loading applications: $e");
      Get.snackbar('Error', 'An error occurred while loading applications');
    } finally {
      isLoading.value = false;
    }
  }

  void filterApplications(String status) {
    selectedFilter.value = status;
    if (status == 'All') {
      filteredApplications.assignAll(applications);
    } else {
      filteredApplications.assignAll(
        applications.where((app) => app.status == status).toList(),
      );
    }
  }

  int getCount(String status) {
    if (status == 'All') return applications.length;
    return applications.where((app) => app.status == status).length;
  }

  void viewApplicationDetails(ApplicationModel app) {
    Get.to(() => const ApplicationDetailsView(), arguments: app);
  }

  Future<void> refreshApplications() async {
    await loadApplications();
  }
}
