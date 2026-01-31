import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:go_roqit_app/View/Widgegt/textField.dart';
import '../controller/additional_information_controller.dart';

class AdditionalInformationView
    extends GetView<AdditionalInformationController> {
  const AdditionalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdditionalInformationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AppIcons.backIcons),
          ),
        ),
        title: Text(
          'Step 6 of 6',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.h),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(height: 2.h, color: const Color(0xFF1B5E3F)),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Help us match you with the right opportunities",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24.h),

            // Preferred Work Type
            Text(
              'Preferred Work Type *',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              children: controller.workTypes.map((type) {
                return Obx(() {
                  final isSelected = controller.selectedWorkType.value == type;
                  return ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (selected) => controller.selectWorkType(type),
                    selectedColor: Colors.white,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1B5E3F)
                          : Colors.grey[300]!,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF1B5E3F)
                          : Colors.grey[600],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    showCheckmark: false,
                  );
                });
              }).toList(),
            ),
            SizedBox(height: 24.h),

            // Languages
            Text(
              'Languages',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: controller.languages.map((language) {
                return Obx(() {
                  final isSelected = controller.selectedLanguages.contains(
                    language,
                  );
                  return FilterChip(
                    label: Text(language),
                    selected: isSelected,
                    onSelected: (selected) =>
                        controller.toggleLanguage(language),
                    selectedColor: Colors.white,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1B5E3F)
                          : Colors.grey[300]!,
                    ),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF1B5E3F)
                          : Colors.grey[600],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    showCheckmark: false,
                  );
                });
              }).toList(),
            ),
            SizedBox(height: 24.h),

            // Salary Expectations
            Text(
              'Salary Expectations',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: textField(
                    '',
                    controller.salaryController,
                    hintText: 'e.g. £25,000',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 56.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.salaryFrequency.value.isEmpty
                              ? null
                              : controller.salaryFrequency.value,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: controller.salaryFrequencies.map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: controller.setSalaryFrequency,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Bio / Professional Summary
            Text(
              'Bio / Professional Summary',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: controller.bioController,
              maxLines: 5,
              maxLength: 500,
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Tell us about yourself and your professional goals',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF1B5E3F),
                    width: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Skills
            Text(
              'Skills',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: textField(
                    '',
                    controller.skillInputController,
                    hintText: 'Add a skill',
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: controller.addSkill,
                  child: Container(
                    height: 56.h,
                    width: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E3F),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Obx(
              () => Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.skills
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => controller.removeSkill(skill),
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 24.h),

            // Upload Resume
            Text(
              'Upload Resume (PDF only)',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: controller.pickResume,
              child: Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_file_outlined,
                      size: 32.sp,
                      color: Colors.grey[500],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Click to upload or drag and drop',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => Text(
                        controller.uploadedResumeName.value ==
                                "Click to upload or drag and drop"
                            ? "PDF only (Max 5MB)"
                            : "File: ${controller.uploadedResumeName.value}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40.h),

            // Bottom Buttons (Skip | Complete)
            SafeArea(
              child: Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: controller.skipStep,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Obx(
                      () => mainButton(
                        loading: controller.isLoading.value,
                        text: 'Complete',
                        onTap: controller.submitApplication,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
