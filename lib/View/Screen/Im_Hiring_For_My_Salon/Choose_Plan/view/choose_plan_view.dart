import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import '../controller/choose_plan_controller.dart';
import '../model/plan_model.dart';

class ChoosePlanView extends GetView<ChoosePlanController> {
  const ChoosePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChoosePlanController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Choose your plan',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AppIcons.backIcons),
          ),
        ),
      ),
      bottomNavigationBar: const HiringNavBar(
        selectedIndex: 0,
      ), // Business tab selected maybe? Or none.
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Column(
          children: [
            // Header Titles
            Text(
              "Choose your plan",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF111827),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Boost your job post to reach more candidates and hire faster.",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),

            // Plans List
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: controller.plans
                    .map((plan) => _buildPlanCard(plan))
                    .toList(),
              );
            }),

            SizedBox(height: 20.h),

            // Tip Box
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light Blue
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFDBEAFE)),
              ),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Tip: ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2563EB), // Blue 600
                      ),
                    ),
                    TextSpan(
                      text:
                          "Pro and Business plans unlock unlimited job postings and help you reach more qualified candidates faster.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3B82F6), // Blue 500
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(PlanModel plan) {
    final borderColor = const Color(0xFF0F5F3E); // Main Green

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Icon + Name
                Row(
                  children: [
                    Icon(
                      _getIconForPlan(plan.id),
                      color: const Color(0xFF374151), // Grey 700
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      plan.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      plan.price,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    if (plan.period != null)
                      Text(
                        plan.period!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                  ],
                ),

                if (plan.discountText != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      plan.discountText!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B5E3F),
                      ),
                    ),
                  ),

                SizedBox(height: 16.h),

                // Features
                ...plan.features
                    .map(
                      (feature) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Icon(
                                feature.isIncluded ? Icons.check : Icons.close,
                                color: feature.isIncluded
                                    ? const Color(0xFF1B5E3F)
                                    : Colors.grey.shade300,
                                size: 16.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                feature.text,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: feature.isIncluded
                                      ? const Color(0xFF4B5563)
                                      : Colors.grey.shade300,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),

                SizedBox(height: 20.h),

                // Button
                if (plan.isCurrentPlan)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(8.r),
                      color: const Color(0xFFF9FAFB),
                    ),
                    child: Text(
                      'Current Plan',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () => controller.selectPlan(plan),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B5E3F),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Badge: Popular
          if (plan.isPopular)
            Positioned(
              top: 20.w,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B5E3F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else if (plan.isCurrentPlan)
            Positioned(
              top: 20.w,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Very light green
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Current Plan',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B5E3F),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIconForPlan(String id) {
    switch (id) {
      case 'starter':
        return Icons.business_center_outlined;
      case 'pro':
        return Icons.bolt;
      case 'business':
        return Icons.workspace_premium_outlined; // Crown icon approximation
      default:
        return Icons.star_outline;
    }
  }
}
