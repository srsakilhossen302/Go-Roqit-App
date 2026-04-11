import 'package:get_x/get.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/plan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_roqit_app/Utils/Toast/toast.dart';

class ChoosePlanController extends GetxController {
  var plans = <PlanModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPlans();
  }

  Future<void> loadPlans() async {
    isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().getData(ApiUrl.getPlans);
      
      print("Fetch Plans Status: ${response.statusCode}");
      print("Fetch Plans Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null && data['plans'] != null) {
          List plansData = data['plans'];
          plans.value = plansData.map((json) => PlanModel.fromJson(json)).toList();
        }
      }
    } catch (e) {
      print("Error loading plans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectPlan(PlanModel plan) async {
    if (plan.isCurrentPlan) return;

    isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().postData(
        "${ApiUrl.createCheckout}/${plan.id}",
        {}, // Empty body as id is in URL
      );

      print("Create Checkout Status: ${response.statusCode}");
      print("Create Checkout Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final String? url = response.body['url'] ?? response.body['data']?['url'];
        if (url != null) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ToastHelper.error("Could not launch checkout page.");
          }
        } else {
          ToastHelper.error("Checkout URL not found in response.");
        }
      } else {
        ToastHelper.error("Failed to create checkout session.");
      }
    } catch (e) {
      print("Error during checkout: $e");
      ToastHelper.error("Connection failed.");
    } finally {
      isLoading.value = false;
    }
  }
}
