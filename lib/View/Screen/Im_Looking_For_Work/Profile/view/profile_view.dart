import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/AdditionalInformation/view/additional_information_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/controller/profile_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/WorkExperience/view/work_experience_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Education/view/profile_education_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Portfolio/view/profile_portfolio_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Settings/view/profile_settings_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/HelpSupport/view/profile_help_support_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/view/user_information_view.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
            color: const Color(0xFF1B5E3F),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ProfileSettingsView());
            },
            icon: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: Color(0xFF1B5E3F),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // Avatar
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 40.r,
                backgroundImage: const NetworkImage(
                  "https://i.pravatar.cc/150?u=a042581f4e29026024d",
                ), // Placeholder
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(height: 12.h),
              Text(
                "Sarah Mitchell",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 24.h),

              // Open To Work Card
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFF1B5E3F)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Open to Work",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Show availability status",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    Obx(
                      () => Switch(
                        value: controller.isOpenToWork.value,
                        onChanged: controller.toggleOpenToWork,
                        activeColor: Colors.white,
                        activeTrackColor: const Color(0xFF1B5E3F),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Stats
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatItem("Portfolio", "2"),
                    VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      width: 40.w,
                    ),
                    _buildStatItem("Experience", "2"),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Menu Items
              _buildMenuItem(
                icon: Icons.person_outline,
                title: "Personal Information",
                subtitle: "Female • London",
                onTap: () {
                  Get.to(() => const UserInformationView());
                },
              ),
              SizedBox(height: 12.h),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: "Additional Information",
                subtitle: "Other",
                onTap: () {
                  Get.to(() => ProfileAdditionalInformationView());
                },
              ),
              SizedBox(height: 12.h),
              _buildMenuItem(
                icon: Icons.work_outline,
                title: "Additional Information",
                subtitle: "2 positions",
                onTap: () {
                  Get.to(() => const ProfileWorkExperienceView());
                },
              ),
              SizedBox(height: 12.h),
              _buildMenuItem(
                icon: Icons.school_outlined,
                title: "Education",
                subtitle: "2 qualifications",
                onTap: () {
                  Get.to(() => const ProfileEducationView());
                },
              ),
              SizedBox(height: 12.h),
              _buildMenuItem(
                icon: Icons.image_outlined,
                title: "Portfolio",
                subtitle: "2 projects",
                onTap: () {
                  Get.to(() => const ProfilePortfolioView());
                },
              ),
              SizedBox(height: 12.h),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: "Settings",
                onTap: () {
                  Get.to(() => const ProfileSettingsView());
                },
              ),
              SizedBox(height: 12.h),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: "Help & Support",
                onTap: () {
                  Get.to(() => const ProfileHelpSupportView());
                },
                showBorder: false,
              ),

              SizedBox(height: 32.h),

              // Logout Button
              GestureDetector(
                onTap: controller.logout,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2), // Light red
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: const Color(0xFFE11D48),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE11D48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B5E3F),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool showBorder = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        color: Colors.transparent, // For hit test
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF1B5E3F), size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
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
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
