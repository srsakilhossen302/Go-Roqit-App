import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Education/controller/profile_education_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/model/profile_model.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

class ProfileEducationView extends GetView<ProfileEducationController> {
  const ProfileEducationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileEducationController());

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
          "Education",
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
                  children: controller.educationList
                      .map((education) => _buildEducationCard(education))
                      .toList(),
                ),
                SizedBox(height: 16.h),
                // Add Education Button Card
                GestureDetector(
                  onTap: () => _showAddEducationSheet(context),
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
                            color: Color(0xFFE8F5E9), // Light green bg
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
                          "Add Education",
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

  Widget _buildEducationCard(Education education) {
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
              color: Color(0xFFE8F5E9), // Light green
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school_outlined,
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
                  education.degreeTitle ?? "",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  education.instituteName ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  education.major ?? "",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    if (education.yearOfPassing != null)
                      _buildTag(education.yearOfPassing!),
                    if (education.duration != null) _buildTag(education.duration!),
                  ],
                ),
                if (education.certificate?.isNotEmpty == true) ...[
                  SizedBox(height: 16.h),
                  Text(
                    "Certificates",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: education.certificate!.length,
                      itemBuilder: (context, idx) {
                        final imgPath = education.certificate![idx];
                        return Container(
                          margin: EdgeInsets.only(right: 8.w),
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              imgPath.startsWith('http')
                                  ? imgPath
                                  : "https://api.goroqit.com$imgPath",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // Light grey
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF64748B),
        ),
      ),
    );
  }

  void _showAddEducationSheet(BuildContext context) {
    controller.clearForm();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        height: 0.85.sh, // Make it tall
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Education",
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
                    _buildTextField("Degree Title *", controller.degreeTitleController, hintText: 'e.g. Bachelor of Science'),
                    SizedBox(height: 16.h),
                    _buildTextField("Major / Specialization", controller.majorController, hintText: 'e.g. Computer Science'),
                    SizedBox(height: 16.h),
                    _buildTextField("Institute Name *", controller.instituteNameController, hintText: 'University or College'),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField("Year of Passing", controller.yearOfPassingController, hintText: '2023'),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildTextField("Duration", controller.durationController, hintText: '4 years'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField("Description", controller.descriptionController, hintText: 'Describe your studies or achievements...'),
                    SizedBox(height: 24.h),
                    Text(
                      'Certificate Image',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => controller.pickCertificate(),
                      child: Obx(() {
                        final path = controller.certificatePath.value;
                        return Container(
                          width: double.infinity,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: path.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload_file, color: Colors.grey),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Upload Certificate',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.file(
                                    File(path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        );
                      }),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value ? null : () => controller.submitEducation(),
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
                                  "Save Education",
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
