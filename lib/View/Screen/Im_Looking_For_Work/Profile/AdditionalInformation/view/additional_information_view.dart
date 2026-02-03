import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/AdditionalInformation/controller/additional_information_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/AdditionalInformation/model/additional_information_model.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

class ProfileAdditionalInformationView
    extends GetView<ProfileAdditionalInformationController> {
  const ProfileAdditionalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileAdditionalInformationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16.sp,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Resume / CV",
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 4),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Obx(() {
          final model = controller.additionalInfoModel.value;
          return Column(
            children: [
              // Resume Card
              _buildResumeCard(model),
              SizedBox(height: 16.h),

              // Professional Summary
              _buildSectionCard(
                title: "Professional Summary",
                onEdit: () =>
                    _showSummarySheet(context, model.professionalSummary),
                content: Text(
                  model.professionalSummary,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Skills
              _buildSectionCard(
                title: "Skills",
                onEdit: () => _showSkillsSheet(context, model.skills),
                content: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: model.skills
                      .map(
                        (skill) => _buildChip(
                          skill,
                          const Color(0xFFE2F5EA),
                          const Color(0xFF1B5E3F),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16.h),

              // Languages
              _buildSectionCard(
                title: "Languages",
                onEdit: () => _showSkillsSheet(
                  context,
                  model.languages,
                  isLanguages: true,
                ), // Reusing skills sheet logic for simplicity or create separate
                content: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: model.languages
                      .map(
                        (lang) => _buildChip(
                          lang,
                          const Color(0xFFF1F5F9),
                          const Color(0xFF64748B),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16.h),

              // Work Preferences
              _buildSectionCard(
                title: "Work Preferences",
                onEdit: () => _showPreferencesSheet(context, model),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preferred Work Type",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      children: model.workPreferences
                          .map(
                            (pref) => _buildChip(
                              pref,
                              const Color(0xFFE0F2FE),
                              const Color(0xFF0284C7),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Salary Expectation",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      model.salaryExpectation,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildResumeCard(AdditionalInformationModel model) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.picture_as_pdf, color: Colors.red, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.resumeFileName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  "Last updated: ${model.resumeLastUpdated}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: controller
                    .updateResume, // TODO: Bottom sheet for resume update?
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 14.sp,
                      color: const Color(0xFF1B5E3F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF1B5E3F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: controller.viewResume,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B5E3F),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "View",
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required VoidCallback onEdit,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: const Color(0xFF1B5E3F),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1B5E3F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          content,
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  // Bottom Sheets
  void _showSummarySheet(BuildContext context, String currentSummary) {
    final summaryController = TextEditingController(text: currentSummary);
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Summary",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: summaryController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                hintText: "Write your professional summary...",
              ),
            ),
            SizedBox(height: 20.h),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateSummary(summaryController.text);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showSkillsSheet(
    BuildContext context,
    List<String> currentItems, {
    bool isLanguages = false,
  }) {
    // Simple implementation: comma separated text field for now, or dynamic add/remove chips
    // For better UX, let's use a text field where user inputs comma separated values
    final textController = TextEditingController(text: currentItems.join(", "));

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isLanguages ? "Edit Languages" : "Edit Skills",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              "Separate items with comma (,)",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: textController,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final items = textController.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();
                    if (isLanguages) {
                      controller.updateLanguages(items);
                    } else {
                      controller.updateSkills(items);
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showPreferencesSheet(
    BuildContext context,
    AdditionalInformationModel model,
  ) {
    final salaryController = TextEditingController(
      text: model.salaryExpectation,
    );
    // State for preferences is tricky in a bottom sheet without stateful widget or Obx inside.
    // Using a simple workaround with local Rx list if needed, or just text field for now to keep it stateless.
    // For detailed UI matching, we'd need a Stateful widget or GetBuilder inside the sheet.
    // Simplifying for now to Text Fields.

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit preferences",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Text(
              "Salary Expectation",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            // Ideal implementation includes Dropdowns/Chips for Work Type
            SizedBox(height: 20.h),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Updating just salary for this snippet, can extend for work type
                    controller.updateWorkPreferences(
                      model.workPreferences,
                      salaryController.text,
                    );
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
