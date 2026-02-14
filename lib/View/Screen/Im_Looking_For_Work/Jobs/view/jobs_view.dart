import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_navigation/src/routes/transitions_type.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/job_details_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/jobs_map_view.dart';

import 'package:go_roqit_app/View/Widgegt/my_refresh_indicator.dart';

class JobsView extends StatelessWidget {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    final JobsController controller = Get.put(JobsController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: MyRefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Jobs",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(
                          () => const JobsMapView(),
                          transition: Transition.fadeIn,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.map_outlined,
                          color: Colors.black,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // Light grey
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Image.asset(
                          AppIcons.search,
                          width: 20.w,
                          height: 20.h,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "Find Your Dream Job",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // Filter Buttons
                Row(
                  children: [
                    _buildFilterButton("All Locations"),
                    SizedBox(width: 12.w),
                    _buildFilterButton("All Levels"),
                  ],
                ),
                SizedBox(height: 20.h),
                // Job List
                Expanded(
                  child: Obx(() {
                    return ListView.separated(
                      itemCount: controller.jobList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final job = controller.jobList[index];
                        return _buildJobCard(job);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ), // Matches SafeArea
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 1),
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F4),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 16.sp,
            color: Colors.grey,
          ), // Placeholder icon type
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.keyboard_arrow_down, size: 16.sp, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildJobCard(JobModel job) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo (Placeholder)
              CircleAvatar(
                radius: 24.r,
                backgroundImage: job.logoUrl.startsWith('http')
                    ? NetworkImage(job.logoUrl)
                    : AssetImage(AppIcons.salon)
                          as ImageProvider, // Fallback to provided asset
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(width: 12.w),
              // Job Info
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => JobDetailsView(job: job),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        job.companyName,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            job.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Chips
          Row(
            children: [
              _buildChip(
                job.jobType,
                const Color(0xFFE8F5E9),
                const Color(0xFF1B5E3F),
              ),
              SizedBox(width: 8.w),
              _buildChip(
                job.salary,
                const Color(0xFFE3F2FD),
                const Color(0xFF1E88E5),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => JobDetailsView(job: job),
                      transition: Transition.rightToLeft,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    elevation: 0,
                  ),
                  child: Text(
                    "Apply now",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
