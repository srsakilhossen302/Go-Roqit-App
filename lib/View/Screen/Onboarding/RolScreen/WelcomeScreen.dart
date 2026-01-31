import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../OnboardingScreen/onboardingScreen.dart';
import '../auth/view/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: 200.h),

            // Main heading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'I want to...',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff111827),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Subheading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Text(
                'Choose how you\'d like to use Roqit',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6B7280),
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Cards section
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Looking for work card
                _buildOptionCard(
                  context: context,
                  icon: Icons.search,
                  title: 'I\'m looking for work',
                  subtitle: 'Find jobs at salons & spas',
                  backgroundColor: Color(0xff1B5E3F),
                  onTap: () {
                    Get.to(() => AuthScreen());
                  },
                ),

                SizedBox(height: 20.h),

                // Hiring for salon card
                _buildOptionCard(
                  context: context,
                  icon: Icons.shopping_bag,
                  title: 'I\'m hiring for my salon',
                  subtitle: 'Find talented professionals',
                  backgroundColor: Colors.white,
                  borderColor: Color(0xffE5E7EB),
                  textColor: Color(0xff111827),
                  subtitleColor: Color(0xff6B7280),
                  onTap: () {
                    // Navigate to hiring flow
                    Get.to(() => AuthScreen());
                  },
                ),
              ],
            ),

            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    Color? borderColor,
    Color textColor = Colors.white,
    Color subtitleColor = Colors.white70,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.5.w)
              : null,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: backgroundColor == Colors.white
                    ? Color(0xffF3F4F6)
                    : Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: backgroundColor == Colors.white
                      ? Color(0xff1B5E3F)
                      : Colors.white,
                  size: 28.sp,
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              color: backgroundColor == Colors.white
                  ? Color(0xffD1D5DB)
                  : Colors.white24,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
