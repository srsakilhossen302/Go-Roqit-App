import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import 'package:go_roqit_app/View/Widgegt/my_refresh_indicator.dart';
import '../controller/applications_controller.dart';
import '../model/application_model.dart';

class ApplicationsView extends GetView<ApplicationsController> {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ApplicationsController());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const HiringNavBar(selectedIndex: 2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildHeader(),
            SizedBox(height: 24.h),
            _buildFilterTabs(),
            SizedBox(height: 16.h),
            _buildApplicationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Applications',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Manage candidate applications',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          _buildFilterChip('All', 4),
          SizedBox(width: 12.w),
          _buildFilterChip('Pending', 2),
          SizedBox(width: 12.w),
          _buildFilterChip('Shortlisted', 1),
          SizedBox(width: 12.w),
          _buildFilterChip(
            'Hired',
            0,
            showCount: false,
          ), // Assuming no count shown or 0
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int count, {bool showCount = true}) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == label;
      return GestureDetector(
        onTap: () => controller.filterApplications(label),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1B5E3F) : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: isSelected
                ? Border.all(color: const Color(0xFF1B5E3F))
                : Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                ),
              ),
              if (showCount) ...[
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildApplicationList() {
    return Expanded(
      child: Obx(() {
        if (controller.applications.isEmpty &&
            controller.filteredApplications.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: const Color(0xFF1B5E3F)),
          );
        }
        if (controller.filteredApplications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 48.sp, color: Colors.grey),
                SizedBox(height: 16.h),
                Text(
                  'No applications found',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return MyRefreshIndicator(
          onRefresh: controller.refreshApplications,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            itemCount: controller.filteredApplications.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return _buildApplicationCard(
                controller.filteredApplications[index],
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildApplicationCard(ApplicationModel app) {
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
          // Top Row: Avatar + Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with rounded corners
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 50.w,
                      width: 50.w,
                      color: Colors.grey.shade200,
                      child: app.imageUrl.isNotEmpty
                          ? Image.network(
                              app.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    app.name[0],
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 20.w,
                                        height: 20.w,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value:
                                              loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                            )
                          : Center(
                              child: Text(
                                app.name[0],
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                    ),
                  ),
                  if (app.hasUnreadMessage)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 12.w,
                        width: 12.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEA580C), // Orange
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),
              // Name, Role, Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          app.role,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    _buildStatusBadge(app.status),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Location and Date
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                app.location,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                app.date,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Skills Chips
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              ...app.skills
                  .take(3)
                  .map(
                    (skill) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1B5E3F),
                        ),
                      ),
                    ),
                  ),
              if (app.skills.length > 3)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '+${app.skills.length - 3}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 16.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r), // Rounded
                    ),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: () {
                    Get.find<ApplicationsController>().viewApplicationDetails(
                      app,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye_outlined, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'View',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (app.status != 'Hired') ...[
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF1B5E3F)),
                      foregroundColor: const Color(0xFF1B5E3F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r), // Rounded
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          // Image has check inside circle outline for Shortlist
                          app.status == 'Shortlisted'
                              ? Icons.check
                              : Icons.check_circle_outline,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          app.status == 'Shortlisted' ? 'Hire' : 'Shortlist',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case 'Pending':
        bgColor = const Color(0xFFFFF7ED); // Light Orange
        textColor = const Color(0xFFEA580C); // Dark Orange
        icon = Icons.access_time_filled;
        break;
      case 'Shortlisted':
        bgColor = const Color(0xFFEFF6FF); // Light Blue
        textColor = const Color(0xFF2563EB); // Dark Blue
        icon = Icons.star; // Or Star
        break;
      case 'Hired':
        bgColor = const Color(0xFFECFDF5); // Light Green
        textColor = const Color(0xFF1B5E3F); // Dark Green
        icon = Icons.check_circle;
        break;
      default:
        bgColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
        icon = Icons.info;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: textColor),
          SizedBox(width: 4.w),
          Text(
            status,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
