import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import '../controller/post_job_controller.dart';

class PostJobView extends GetView<PostJobController> {
  const PostJobView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PostJobController>()) {
      Get.put(PostJobController());
    }

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
                  return _buildStep1(context);
                case 2:
                  return _buildStep2(context);
                case 3:
                  return _buildStep3(context);
                case 4:
                  return _buildStep4();
                default:
                  return _buildStep1(context);
              }
            }),
          ),

          // Footer Button
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Obx(
              () => mainButton(
                loading: controller.isLoading.value,
                onTap: controller.onContinue,
                text: controller.currentStep.value == 4 ? 'Publish' : 'Continue',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 1: JOB BASICS ---
  Widget _buildStep1(BuildContext context) {
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

          _buildLabel('Role Type / Category *'),
          _buildSelectionField(
            context: context,
            controller: controller.roleTypeController,
            hint: 'Select Category',
            options: controller.categories,
          ),
          SizedBox(height: 20.h),

          _buildLabel('Job Location (Address)'),
          _buildTextField(
            controller: controller.locationController,
            hint: 'e.g. Banani, Dhaka',
          ),
          SizedBox(height: 20.h),

          _buildLabel('Engagement Type *'),
          _buildSelectionField(
            context: context,
            controller: controller.engagementTypeController,
            hint: 'Select engagement',
            options: controller.engagementTypes,
          ),
          SizedBox(height: 20.h),

          _buildLabel('Start Date *'),
          GestureDetector(
            onTap: () => controller.selectStartDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                    "${controller.startDate.value.day}/${controller.startDate.value.month}/${controller.startDate.value.year}",
                    style: TextStyle(fontSize: 14.sp, color: const Color(0xFF111827)),
                  )),
                  const Icon(Icons.calendar_today, size: 18, color: Color(0xFF6B7280)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),

          _buildLabel('Employment Type *'),
          _buildSelectionField(
            context: context,
            controller: controller.employmentTypeController,
            hint: 'Select type',
            options: ['Full-time', 'Part-time', 'Temp'],
          ),
        ],
      ),
    );
  }

  // --- STEP 2: COMPENSATION ---
  Widget _buildStep2(BuildContext context) {
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
          _buildSelectionField(
            context: context,
            controller: controller.salaryTypeController,
            hint: 'Select frequency',
            options: ['yearly', 'monthly', 'weekly', 'hourly'],
          ),
          SizedBox(height: 20.h),

        ],
      ),
    );
  }

  // --- STEP 3: JOB DETAILS ---
  Widget _buildStep3(BuildContext context) {
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

          _buildLabel('Experience Level *'),
          _buildSelectionField(
            context: context,
            controller: controller.experienceLabelController,
            hint: 'Select level',
            options: ['Junior', 'Mid-Level', 'Senior', 'Master'],
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
                  controller.jobTitleController.text,
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
                          : 'Location set',
                      color: const Color(0xFFEFF6FF),
                      textColor: const Color(0xFF2563EB),
                      iconColor: const Color(0xFF2563EB),
                    ),
                    _buildTag(
                      icon: Icons.attach_money,
                      text:
                          '£${controller.minSalaryController.text} - £${controller.maxSalaryController.text}/${controller.salaryTypeController.text}',
                      color: const Color(0xFFECFDF5),
                      textColor: const Color(0xFF0F5F3E),
                      iconColor: const Color(0xFF0F5F3E),
                      isMoney: true,
                    ),
                    _buildTag(
                      text: controller.employmentTypeController.text.isNotEmpty
                          ? controller.employmentTypeController.text
                          : 'Full-time',
                      color: const Color(0xFFF3E8FF),
                      textColor: const Color(0xFF7E22CE),
                    ),
                    _buildTag(
                      text: controller.experienceLabelController.text.isNotEmpty
                          ? controller.experienceLabelController.text
                          : 'Mid-Level',
                      color: const Color(0xFFFFF7ED),
                      textColor: const Color(0xFFEA580C),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                _buildReviewSection(
                  'Description',
                  controller.descriptionController.text,
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
              'Your job will be published with coordinates: [${controller.longitude.value}, ${controller.latitude.value}].',
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
            Text(
              '£',
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
          content.isNotEmpty ? content : 'No content provided',
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

  Widget _buildSelectionField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required List<String> options,
  }) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Text(
                  hint,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey.shade100, height: 1),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return ListTile(
                        title: Text(
                          option,
                          style: TextStyle(
                            color: controller.text == option ? const Color(0xFF0F5F3E) : Colors.black,
                            fontWeight: controller.text == option ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: controller.text == option
                            ? const Icon(Icons.check_circle, color: Color(0xFF0F5F3E))
                            : null,
                        onTap: () {
                          controller.text = option;
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          isScrollControlled: true,
        );
      },
      child: AbsorbPointer(
        child: _buildTextField(
          controller: controller,
          hint: hint,
        ),
      ),
    );
  }
}
