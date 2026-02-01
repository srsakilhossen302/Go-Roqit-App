import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import '../controller/post_job_controller.dart';

class PostJobView extends GetView<PostJobController> {
  const PostJobView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PostJobController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'Step 1 of 4',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF111827),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 40), // For balance
          ],
        ),
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F5F3E),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Basics',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'What position are you hiring for?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  _buildLabel('Job Title *'),
                  _buildTextField(
                    controller: controller.jobTitleController,
                    hint: 'e.g. Senior Hair Stylist',
                  ),
                  SizedBox(height: 20.h),

                  _buildLabel('Role Type *'),
                  _buildTextField(
                    controller: controller.roleTypeController,
                    hint: 'e.g. Barber, Stylist',
                  ),
                  SizedBox(height: 20.h),

                  _buildLabel('Location *'),
                  _buildTextField(
                    controller: controller.locationController,
                    hint: 'e.g. London, United Kingdom',
                  ),
                  SizedBox(height: 20.h),

                  _buildLabel('Employment Type *'),
                  _buildTextField(
                    controller: controller.employmentTypeController,
                    hint: 'e.g. Full-time, Part-time',
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // Footer Button
          Padding(
            padding: EdgeInsets.all(24.w),
            child: mainButton(
              loading: false,
              onTap: controller.onContinue,
              text: 'Continue',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF111827),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF0F5F3E), width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
