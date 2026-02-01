import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';

import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import '../controller/job_posts_controller.dart';
import '../model/job_post_model.dart';
import '../../Post_Job/view/post_job_view.dart';

class JobPostsView extends GetView<JobPostsController> {
  const JobPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(JobPostsController());

    return Scaffold(
      backgroundColor:
          Colors.white, // Dark background as per last prompt request?
      // The shared image shows a white/light theme again (Job Posts list).
      // I will stick to White theme based on the image content provided primarily.
      // Wait, the prompt says "Job Posting" header in dark mode in previous image, but this specific task "sem to sem ata digain"
      // implies copying the white list view image provided.
      bottomNavigationBar: const HiringNavBar(selectedIndex: 1), // Jobs Tab

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const PostJobView());
        },
        backgroundColor: const Color(0xFF1B5E3F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Job Posts',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              Obx(
                () => Text(
                  '${controller.activeJobPosts.length} active job postings',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search jobs..',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Color(0xFF1B5E3F)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              SizedBox(height: 20.h),

              // Job List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    itemCount: controller.activeJobPosts.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      return _buildJobPostCard(
                        context,
                        controller.activeJobPosts[index],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobPostCard(BuildContext context, JobPostModel job) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
          // Header: Title + Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),

              // Popup Menu Button
              Theme(
                data: Theme.of(context).copyWith(
                  popupMenuTheme: PopupMenuThemeData(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.grey.shade400),
                  onSelected: (value) {
                    if (value == 'view') controller.viewDetails(job.id);
                    if (value == 'edit') controller.editJob(job.id);
                    if (value == 'delete') controller.deleteJob(job.id);
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'view',
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: 18.sp,
                                color: Colors.grey[700],
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'View Details',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                size: 18.sp,
                                color: Colors.grey[700],
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Edit Job',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                size: 18.sp,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Delete Job',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),
          Text(
            job.employmentType,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2563EB), // Blue
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                job.location,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '\$ ', // Using $ per design, though original model used £. Changing to $ icon or text visually.
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
              SizedBox(width: 4.w),
              Text(
                job.salaryRange,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(color: Colors.grey.shade100),
          SizedBox(height: 8.h),

          // Footer: Time + Applicant Count Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    job.postedTime,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Light Green
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 14.sp,
                      color: const Color(0xFF1B5E3F),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      job.applicantCount.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B5E3F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
