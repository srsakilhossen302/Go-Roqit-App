import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../controller/job_details_controller.dart';
import '../../Post_Job/view/post_job_view.dart';

class JobDetailsView extends StatelessWidget {
  const JobDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final JobDetailsController controller = Get.put(JobDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job Details',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'View and manage',
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
          ],
        ),
        centerTitle: false,
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
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteConfirmation(context, controller, controller.job.value!.id);
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.job.value == null) {
          return const Center(child: Text("Job not found"));
        }
        final job = controller.job.value!;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Job Info Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: job.companyLogo.isNotEmpty
                              ? NetworkImage("${ApiUrl.IMGUrl}${job.companyLogo}")
                              : null,
                          child: job.companyLogo.isEmpty ? const Icon(Icons.business) : null,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.companyName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              job.category,
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5), // Light Green
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        job.employmentType,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1B5E3F),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _buildIconText(Icons.location_on_outlined, job.jobLocation),
                    _buildIconText(
                      Icons.attach_money,
                      "${job.minSalary} - ${job.maxSalary} / ${job.paymentType}",
                    ),
                    _buildIconText(
                      Icons.calendar_today_outlined,
                      'Posted ${job.createdAt.length > 10 ? job.createdAt.substring(0, 10) : job.createdAt}',
                    ),
                    _buildIconText(
                      Icons.people_outline,
                      '${job.applicantCount} applicants',
                    ),
                    _buildIconText(
                      Icons.work_outline,
                      'Experience: ${job.experienceLabel}',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // 2. Description Card
              _buildSectionCard(
                title: "Description",
                content: Text(
                  job.description.isNotEmpty
                      ? job.description
                      : "No description provided.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to applicants view
                      },
                      child: Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B5E3F),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Applicants',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const PostJobView(), arguments: job);
                      },
                      child: Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: const Color(0xFF111827),
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Edit Job',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  void _showDeleteConfirmation(BuildContext context, JobDetailsController controller, String id) {
    Get.defaultDialog(
      title: "Delete Job",
      middleText: "Are you sure you want to delete this job post?",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        if (Get.isOverlaysOpen) {
          Get.back(); // Close dialog
        }
        final success = await controller.deleteJob(id);
        if (success) {
          Get.back(); // Return to previous screen
        }
      },
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: Colors.grey.shade500),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF4B5563), // Gray 700
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }
}
