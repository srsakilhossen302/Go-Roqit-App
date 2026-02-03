import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

class JobDetailsView extends StatelessWidget {
  final JobModel job;

  const JobDetailsView({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFF5F7F9),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 16.sp,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "details",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFF5F7F9),
              child: Icon(
                Icons.share_outlined,
                color: Colors.black,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  // Header Section
                  Container(
                    height: 80.r,
                    width: 80.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: DecorationImage(
                        image: NetworkImage(job.logoUrl),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    job.companyName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Badges Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeaderBadge(
                        Icons.location_on_outlined,
                        job.location,
                      ),
                      SizedBox(width: 8.w),
                      _buildHeaderBadge(
                        Icons.business_center_outlined,
                        job.jobType,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          job.postedTime,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Info Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          Icons.work_outline,
                          "Job Type",
                          job.jobType,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildInfoCard(
                          Icons.attach_money,
                          "Expected Salary",
                          job.salary.replaceAll("/Hour", " /Per Hour"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          Icons.access_time,
                          "Working Hours",
                          job.workingHours,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildInfoCard(
                          Icons.apartment,
                          "Work System",
                          job.workSystem,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Skills Section
                  _buildContentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Skills that must be mastered",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: job.skills
                              .map((skill) => _buildSkillChip(skill))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // About Company
                  _buildExpandableCard(
                    title: "About Company",
                    content: Text(
                      job.companyDescription,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Business Photos
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Business Photos",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: job.businessPhotos.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: DecorationImage(
                              image: NetworkImage(job.businessPhotos[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Job Requirements
                  _buildExpandableCard(
                    title: "Job Requirements",
                    content: Column(
                      children: job.requirements
                          .map(
                            (req) => Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.h),
                                    child: CircleAvatar(
                                      radius: 2.r,
                                      backgroundColor: const Color(0xFF1B5E3F),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      req,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Benefits
                  _buildExpandableCard(
                    title: "Benefits",
                    content: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: job.benefits
                          .map((benefit) => _buildGreenChip(benefit))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),

          // Apply Button
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E3F),
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Apply Now",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildExpandableCard({
    required String title,
    required Widget content,
  }) {
    return _buildContentCard(
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
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
                size: 24.sp,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[200], thickness: 1),
          SizedBox(height: 12.h),
          content,
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: Colors.grey),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9).withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1B5E3F), size: 20.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(fontSize: 10.sp, color: const Color(0xFF94A3B8)),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF1E293B),
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildGreenChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF1B5E3F),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
