import 'package:get_x/get.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../../Job_Posts/model/job_post_model.dart';

class JobDetailsController extends GetxController {
  final job = Rxn<JobPostModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is JobPostModel) {
      job.value = Get.arguments;
      // Fetch fresh data if needed
      fetchJobDetails(job.value!.id);
    } else if (Get.arguments is String) {
      fetchJobDetails(Get.arguments);
    }
  }

  Future<void> fetchJobDetails(String id) async {
    isLoading.value = true;
    try {
      final token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
      final headers = {'Authorization': 'Bearer $token'};
      
      final response = await Get.find<ApiClient>().getData("/job/$id", headers: headers);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        job.value = JobPostModel.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch job details');
      }
    } catch (e) {
      print("Error fetching job: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
