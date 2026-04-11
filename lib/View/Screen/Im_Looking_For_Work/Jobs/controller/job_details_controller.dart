import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';

class JobDetailsController extends GetxController {
  var isLoading = false.obs;
  var detailedJob = Rxn<JobModel>();

  Future<void> fetchSingleJob(String jobId) async {
    isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().getData("${ApiUrl.getJobs}/$jobId");
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
}
