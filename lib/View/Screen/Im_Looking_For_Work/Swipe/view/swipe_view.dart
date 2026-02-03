import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Swipe/controller/swipe_controller.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

class SwipeView extends StatelessWidget {
  const SwipeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure JobsController is in memory, though it likely is from Home/Jobs views
    if (!Get.isRegistered<JobsController>()) {
      Get.put(JobsController());
    }
    final SwipeController controller = Get.put(SwipeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF1FDF7), // Light green tint background
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Header
            Text(
              "Find Your Dream Job",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => Text(
                "${controller.jobsController.jobList.length} opportunities waiting",
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 10.h), // Spacer
            // Swiper Area
            Expanded(
              child: Obx(() {
                if (controller.jobsController.jobList.isEmpty) {
                  return Center(child: Text("No more jobs to show"));
                }
                return AppinioSwiper(
                  controller: controller.swiperController,
                  backgroundCardCount: 2,
                  onSwipeEnd: controller.onSwipe,
                  cardCount: controller.jobsController.jobList.length,
                  cardBuilder: (BuildContext context, int index) {
                    final job = controller.jobsController.jobList[index];
                    return _buildSwipeCard(job);
                  },
                );
              }),
            ),

            // Controls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.close,
                    color: Colors.red,
                    onTap: () => controller.swipeLeft(),
                  ),
                  _buildControlButton(
                    icon: Icons.info_outline,
                    color: Colors.blue,
                    onTap: () {
                      // Navigate to details if needed, or flipping card?
                      // For now, let's keep it simple or implement navigation
                      // Get.to(() => JobDetailsView(job: currentJob));
                      // Need to track current index for this.
                    },
                    isSmall: true,
                  ),
                  _buildControlButton(
                    icon: Icons.favorite,
                    color: const Color(0xFF1B5E3F),
                    onTap: () => controller.swipeRight(),
                    isFilled: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 2),
    );
  }

  Widget _buildSwipeCard(JobModel job) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w), // Add some side margin
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          children: [
            // Image Area
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    job.logoUrl, // Using logoUrl as main image for now
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(
                            0.2,
                          ), // Subtle gradient at bottom of image
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info Area
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      job.companyName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: const Color(0xFF1B5E3F).withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        job.salary,
                        style: TextStyle(
                          color: const Color(0xFF1B5E3F),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    SizedBox(height: 8.h),

                    Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: 16.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          job.jobType,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13.sp,
                          ),
                        ),

                        SizedBox(width: 16.w),

                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            job.location,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      job.companyDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isFilled = false,
    bool isSmall = false,
  }) {
    double size = isSmall ? 50.r : 60.r;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: isFilled ? color : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isFilled ? Colors.white : color,
          size: isSmall ? 24.sp : 30.sp,
        ),
      ),
    );
  }
}
