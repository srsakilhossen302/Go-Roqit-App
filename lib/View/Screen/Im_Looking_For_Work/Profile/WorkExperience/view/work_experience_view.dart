import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/WorkExperience/controller/work_experience_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/model/profile_model.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

class ProfileWorkExperienceView extends GetView<ProfileWorkExperienceController> {
  const ProfileWorkExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileWorkExperienceController());

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
          "Career History",
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 4),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async => controller.refreshData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Column(
                  children: controller.workExperiences
                      .map((experience) => _buildExperienceCard(experience))
                      .toList(),
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => _showAddWorkExperienceSheet(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: const Color(0xFF1B5E3F),
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Add Work Experience",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(WorkExperience experience) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.business_center_outlined,
              color: const Color(0xFF1B5E3F),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.jobTitle ?? "",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  experience.companyName ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  experience.location ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${experience.startDate?.split('T').first ?? ""} - ${experience.endDate?.split('T').first ?? "Present"}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (experience.employmentType != null)
                      _buildTag(
                        experience.employmentType!,
                        const Color(0xFFE0F2FE),
                        const Color(0xFF0284C7),
                      ),
                    if (experience.endDate == null) ...[
                      SizedBox(width: 8.w),
                      _buildTag(
                        "Current Position",
                        const Color(0xFFE2F5EA),
                        const Color(0xFF1B5E3F),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
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

  void _showAddWorkExperienceSheet(BuildContext context) {
    controller.clearForm();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        height: 0.85.sh, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Work Experience",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Job Title *", controller.jobTitleController, hintText: 'e.g. Software Engineer'),
                    SizedBox(height: 16.h),
                    _buildTextField("Company Name *", controller.companyNameController, hintText: 'e.g. Google'),
                    SizedBox(height: 16.h),
                    _buildTextField("Location", controller.locationController, hintText: 'e.g. California, US'),
                    SizedBox(height: 16.h),
                    Text(
                      "Employment Type *",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: controller.selectedEmploymentType.value.isEmpty ? null : controller.selectedEmploymentType.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        ),
                        hint: Text("Select Type", style: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp)),
                        items: controller.employmentTypes.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) controller.selectedEmploymentType.value = val;
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectDate(context, true),
                            child: AbsorbPointer(
                              child: Obx(() => _buildTextField("Start Date *", TextEditingController(text: controller.startDate.value), hintText: 'YYYY-MM-DD')),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Obx(
                            () => GestureDetector(
                              onTap: controller.isCurrentlyWorking.value ? null : () => controller.selectDate(context, false),
                              child: AbsorbPointer(
                                child: _buildTextField("End Date", TextEditingController(text: controller.isCurrentlyWorking.value ? 'Present' : controller.endDate.value), hintText: 'YYYY-MM-DD'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("I currently work here", style: TextStyle(fontSize: 14.sp)),
                        value: controller.isCurrentlyWorking.value,
                        activeColor: const Color(0xFF1B5E3F),
                        onChanged: controller.toggleCurrentlyWorking,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField("Description", controller.experienceController, hintText: 'Describe your role...'),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value ? null : () => controller.submitWorkExperience(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B5E3F),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Save Work Experience",
                                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}
