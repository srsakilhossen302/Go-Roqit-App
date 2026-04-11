import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/plan_model.dart';
import '../../Payment/view/payment_view.dart';

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

  void selectPlan(PlanModel plan) {
    if (plan.isCurrentPlan) return;

    // Logic to initiate purchase or upgrade
    Get.to(() => const PaymentView(), arguments: plan);
  }
}
