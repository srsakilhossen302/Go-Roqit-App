import 'package:get_x/get.dart';
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

  void loadPlans() {
    isLoading.value = true;

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      plans.value = [
        PlanModel(
          id: 'starter',
          name: 'Starter',
          price: 'Free',
          isCurrentPlan: true,
          features: [
            PlanFeature('1 Free Job Post / Month'),
            PlanFeature('Basic Job Filters'),
            PlanFeature('Unlimited Job Posts', isIncluded: false),
          ],
        ),
        PlanModel(
          id: 'pro',
          name: 'Pro',
          price: '£10',
          isPopular: true,
          features: [
            PlanFeature('Unlimited Job Posts'),
            PlanFeature(
              'Freelance, Part-Time, Apprenticeship &\nGuest Spot Options',
            ),
            PlanFeature('Candidate Applications Direct to Your Inbox'),
          ],
        ),
        PlanModel(
          id: 'business',
          name: 'Business',
          price: '£99',
          period: '/Yearly',
          discountText: 'Save £21/year',
          features: [
            PlanFeature('Unlimited Job Posts'),
            PlanFeature('Priority Placement in Search Results'),
            PlanFeature('Monthly Insights on Your Job Reach'),
            PlanFeature('All Pro features Included'),
          ],
        ),
      ];
      isLoading.value = false;
    });
  }

  void selectPlan(PlanModel plan) {
    if (plan.isCurrentPlan) return;

    // Logic to initiate purchase or upgrade
    Get.to(() => const PaymentView(), arguments: plan);
  }
}
