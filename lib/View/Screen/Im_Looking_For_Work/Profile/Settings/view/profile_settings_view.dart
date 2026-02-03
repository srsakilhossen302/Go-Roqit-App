import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/Settings/controller/profile_settings_controller.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileSettingsController());

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
          "Settings",
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 4),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildSettingItem(
              icon: Icons.shield_outlined,
              title: "Account Settings",
              onTap: controller.onAccountSettingsTap,
            ),
            SizedBox(height: 16.h),
            _buildSettingItem(
              icon: Icons.notifications_none_outlined,
              title: "Notifications",
              onTap: controller.onNotificationsTap,
            ),
            SizedBox(height: 16.h),
            _buildSettingItem(
              icon: Icons.lock_outline,
              title: "Privacy & Security",
              onTap: controller.onPrivacySecurityTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9), // Light grey/green background
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1B5E3F), // Green icon
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
