import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../auth/view/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                'I want to...',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff111827),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              // Subtitle
              Text(
                'Choose how you\'d like to use Roqit',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              // Option 1: I'm looking for work
              _buildOptionCard(
                icon: AppIcons.kachi, // Assuming scissor icon
                title: "I'm looking for work",
                subtitle: "Find jobs at salons & spas",
                backgroundColor: const Color(0xFF1B5E3F),
                textColor: Colors.white,
                subtitleColor: Colors.white.withOpacity(0.8),
                iconBgColor: Colors.white.withOpacity(0.2),
                iconColor: Colors.white,
                onTap: () async {
                  print("Tap: Looking for work. Saving role: user");
                  await SharePrefsHelper.setString(
                    SharedPreferenceValue.role,
                    'user',
                  );
                  print(SharedPreferenceValue.role);
                  print("Role Saved. Navigating to Auth.");
                  Get.to(() => const AuthScreen());
                },
              ),

              SizedBox(height: 20.h),

              // Option 2: I'm hiring for my salon
              _buildOptionCard(
                icon: AppIcons.salon, // Assuming shop/salon icon
                title: "I'm hiring for my salon",
                subtitle: "Find talented professionals",
                backgroundColor: Colors.white,
                borderColor: const Color(0xFF1B5E3F),
                textColor: const Color(0xFF1B5E3F),
                subtitleColor: Colors.grey[600]!,
                iconBgColor: const Color(0xFFE8F5E9), // Light green tint
                iconColor: const Color(0xFF1B5E3F),
                onTap: () async {
                  print("Tap: Hiring for salon. Saving role: hiring");
                  await SharePrefsHelper.setString(
                    SharedPreferenceValue.role,
                    'hiring',
                  );
                  print(SharedPreferenceValue.role);
                  print("Role Saved. Navigating to Auth.");
                  Get.to(() => const AuthScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required Color textColor,
    required Color subtitleColor,
    required Color iconBgColor,
    required Color iconColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.w)
              : Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Box
            Container(
              height: 56.w,
              width: 56.w,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(14.w),
              child: Image.asset(icon, color: iconColor),
            ),
            SizedBox(width: 16.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
