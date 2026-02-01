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
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: controller.onBack,
                child: Text(
                  controller.currentStep.value == 1 ? 'Cancel' : 'Back',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                'Step ${controller.currentStep.value} of 4',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Obx(
              () => Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Container(
                      height: 4.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: index < controller.currentStep.value
                            ? const Color(0xFF0F5F3E)
                            : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              switch (controller.currentStep.value) {
                case 1:
                  return _buildStep1();
                case 2:
                  return _buildStep2();
                case 3:
                  return _buildStep3();
                case 4:
                  return _buildStep4();
                default:
                  return _buildStep1();
              }
            }),
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

  // --- STEP 1: JOB BASICS ---
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Basics', style: _titleStyle),
          SizedBox(height: 8.h),
          Text('What position are you hiring for?', style: _subtitleStyle),
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
            hint: 'e.g. Shoreditch, London',
          ),
          SizedBox(height: 20.h),

          _buildLabel('Employment Type *'),
          _buildTextField(
            controller: controller.employmentTypeController,
            hint: 'e.g. Full-time, Part-time',
          ),
        ],
      ),
    );
  }

  // --- STEP 2: COMPENSATION ---
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compensation', style: _titleStyle),
          SizedBox(height: 8.h),
          Text("What's the salary range?", style: _subtitleStyle),
          SizedBox(height: 32.h),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Min Salary *'),
                    _buildTextField(
                      controller: controller.minSalaryController,
                      hint: '£ 28000',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Max Salary *'),
                    _buildTextField(
                      controller: controller.maxSalaryController,
                      hint: '£ 35000',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          _buildLabel('Salary Type *'),
          _buildTextField(
            controller: controller.salaryTypeController,
            hint: 'e.g. Per Year',
          ),
          SizedBox(height: 20.h),

          _buildLabel('Benefits (Optional)'),
          _buildTextField(
            controller: controller.benefitsController,
            hint: 'Health insurance, flexible hours...',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  // --- STEP 3: JOB DETAILS ---
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Details', style: _titleStyle),
          SizedBox(height: 8.h),
          Text('Describe the role', style: _subtitleStyle),
          SizedBox(height: 32.h),

          _buildLabel('Description *'),
          _buildTextField(
            controller: controller.descriptionController,
            hint: 'Describe the role and responsibilities...',
            maxLines: 4,
          ),
          SizedBox(height: 20.h),

          _buildLabel('Requirements *'),
          _buildTextField(
            controller: controller.requirementsController,
            hint: 'List skills, experience, certifications...',
            maxLines: 4,
          ),
          SizedBox(height: 20.h),

          _buildLabel('Work Schedule'),
          _buildTextField(
            controller: controller.workScheduleController,
            hint: 'Monday - Friday, 9 AM - 6 PM',
          ),
        ],
      ),
    );
  }

  // --- STEP 4: REVIEW & PUBLISH ---
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review & Publish', style: _titleStyle),
          SizedBox(height: 8.h),
          Text('Review your job posting', style: _subtitleStyle),
          SizedBox(height: 32.h),

          // Job Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'salon', // Hardcoded or dynamic salon name
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 12.h),

                // Tags Row
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _buildTag(
                      icon: Icons.location_on,
                      text: controller.locationController.text.isNotEmpty
                          ? controller.locationController.text
                          : 'London, UK',
                      color: const Color(0xFFEFF6FF),
                      textColor: const Color(0xFF2563EB),
                      iconColor: const Color(0xFF2563EB),
                    ),
                    _buildTag(
                      icon: Icons.attach_money,
                      text:
                          '£${controller.minSalaryController.text} - £${controller.maxSalaryController.text}/${controller.salaryTypeController.text.replaceAll('per ', '')}',
                      color: const Color(0xFFECFDF5),
                      textColor: const Color(0xFF0F5F3E),
                      iconColor: const Color(0xFF0F5F3E),
                      isMoney: true, // Use proper logic
                    ),
                    _buildTag(
                      text: controller.employmentTypeController.text.isNotEmpty
                          ? controller.employmentTypeController.text
                          : 'Part Time',
                      color: const Color(0xFFF3E8FF),
                      textColor: const Color(0xFF7E22CE),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                _buildReviewSection(
                  'Description',
                  controller.descriptionController.text,
                ),
                SizedBox(height: 12.h),
                _buildReviewSection(
                  'Requirements',
                  controller.requirementsController.text,
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Info Box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Text(
              'Your job will be published and visible to all professionals.',
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF2563EB)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag({
    IconData? icon,
    required String text,
    required Color color,
    required Color textColor,
    Color? iconColor,
    bool isMoney = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.sp, color: iconColor),
            SizedBox(width: 4.w),
          ] else if (isMoney) ...[
            // Logic to show currency symbol if needed without icon
            Text(
              '\$',
              style: TextStyle(fontSize: 12.sp, color: textColor),
            ),
            SizedBox(width: 2.w),
          ],
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF111827),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          content.isNotEmpty ? content : 'wwwwwwwwww',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // --- HELPERS ---
  TextStyle get _titleStyle => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF111827),
  );

  TextStyle get _subtitleStyle =>
      TextStyle(fontSize: 14.sp, color: const Color(0xFF6B7280));

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
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
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
