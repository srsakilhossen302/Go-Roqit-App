import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import '../controller/home_controller.dart';
import '../../../../Widgegt/JobSeekerNavBar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: const NetworkImage(
                            "https://i.pravatar.cc/150?u=a042581f4e29026024d",
                          ), // Placeholder
                          backgroundColor: Colors.grey[200],
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              "Sarah",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Badge(
                            smallSize: 8,
                            backgroundColor: Colors.red,
                            child: Image.asset(
                              AppIcons.notification,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      "Every day is a new opportunity to grow and give your best",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Search Bar
                    TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF5F7F9),
                        hintText: "Find Your Dream Job",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Filters
                    Row(
                      children: [
                        Expanded(child: _buildFilterDropdown("All Locations")),
                        SizedBox(width: 12.w),
                        Expanded(child: _buildFilterDropdown("All Levels")),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Promo Card
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1522337660859-02fbefca4702?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                          ), // Placeholder Salon Image
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Find jobs that match your skills",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Swipe through personalized job recommendations",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1B5E3F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Swipe Now",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Job Recommendations Header
                    Text(
                      "Job recommendations for you",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Job List
                    Obx(
                      () => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.jobRecommendations.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final job = controller.jobRecommendations[index];
                          return _buildJobCard(job);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 0),
    );
  }

  Widget _buildFilterDropdown(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 13.sp),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[100]!),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundImage: const NetworkImage(
                  "https://source.unsplash.com/random/100x100?salon",
                ), // Placeholder
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['role'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job['company'],
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.bookmark_border, color: Colors.grey[400]),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: (job['tags'] as List).map<Widget>((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: const Color(0xFF1B5E3F),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                job['location'],
                style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.trending_up, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                job['level'],
                style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
              ),
              const Spacer(),
              Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                job['posted'],
                style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
