import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:go_roqit_app/View/Widgegt/textField.dart';
import '../controller/education_controller.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EducationController());

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
          'Step 2 of 6',
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
                flex: 2,
                child: Container(height: 2.h, color: const Color(0xFF1B5E3F)),
              ),
              Expanded(
                flex: 4,
                child: Container(height: 2.h, color: Colors.grey[200]),
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
              'Education',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Add your academic qualifications",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24.h),

            // Education Entry Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey[200]!),
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
                  textField(
                    'Degree Title *',
                    controller.degreeTitleController,
                    hintText: 'e.g. Bachelor of Science',
                  ),
                  SizedBox(height: 16.h),
                  textField(
                    'Major / Specialization',
                    controller.majorController,
                    hintText: 'e.g. Computer Science',
                  ),
                  SizedBox(height: 16.h),
                  textField(
                    'Institute Name *',
                    controller.instituteNameController,
                    hintText: 'University or College',
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: textField(
                          'Year of Passing',
                          controller.yearOfPassingController,
                          hintText: '2023',
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: textField(
                          'Duration',
                          controller.durationController,
                          hintText: '4 years',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  textField(
                    'Description',
                    controller.descriptionController,
                    hintText: 'Describe your studies or achievements...',
                  ),
                  SizedBox(height: 24.h),

                  // Certificate Section
                  Text(
                    'Certificate *',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16.w),
                          child: SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Camera'),
                                  onTap: () {
                                    controller.pickCertificate(
                                      ImageSource.camera,
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Gallery'),
                                  onTap: () {
                                    controller.pickCertificate(
                                      ImageSource.gallery,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Obx(() {
                      final path = controller.certificatePath.value;
                      return Container(
                        width: double.infinity,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey[300]!),
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

                  // Inner Buttons (Cancel | Add Education)
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48.h,
                          child: OutlinedButton(
                            onPressed: controller.clearForm,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: SizedBox(
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: controller.submitEducation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B5E3F),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                            child: Text(
                              'Add Education',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // Bottom Buttons (Skip | Continue)
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
                        text: 'Continue',
                        onTap: controller.submitEducation,
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
