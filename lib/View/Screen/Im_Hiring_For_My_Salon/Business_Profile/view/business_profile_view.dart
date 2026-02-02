import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import '../controller/business_profile_controller.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/auth_screen.dart';
import 'edit_business_profile_view.dart';

import 'package:go_roqit_app/View/Widgegt/my_refresh_indicator.dart';

class BusinessProfileView extends GetView<BusinessProfileController> {
  const BusinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BusinessProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const HiringNavBar(selectedIndex: 4),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value || controller.profile.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = controller.profile.value!;

          return MyRefreshIndicator(
            onRefresh: controller.refreshProfile,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 20.sp),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Column(
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          Text(
                            'Personal & company info',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _showCustomMenu(context, details.globalPosition);
                        },
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.menu,
                            size: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Title Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Profile',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          Text(
                            'Personal & company information',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Populate fields before navigating (optional if already bound to observable)
                          controller
                              .loadProfile(); // Or just rely on reactive state if already loaded
                          // Ideally controller state is persistent or we re-populate
                          // For now, let's assume we can navigate and controller has data
                          Get.to(() => const EditBusinessProfileView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Profile Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Cover Image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                          child: Container(
                            height: 80.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(
                                0xFF0F5F3E,
                              ), // Fallback color matches theme green
                              image: DecorationImage(
                                // Using a gradient or texture as placeholder for the green pattern in image
                                image: NetworkImage(
                                  "https://www.transparenttextures.com/patterns/cubes.png",
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.2,
                              ),
                            ),
                          ),
                        ),

                        // Content
                        Transform.translate(
                          offset: Offset(0, -30.h), // Pull up logo
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Logo
                                Container(
                                  width: 60.w,
                                  height: 60.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      profile.logoUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, o, s) => const Icon(
                                        Icons.business,
                                      ), // Component placeholder
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  profile.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFE0E7FF,
                                    ), // Light blue
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    profile.category,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(
                                        0xFF3730A3,
                                      ), // Dark blue text
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  profile.description,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
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

                  SizedBox(height: 20.h),

                  // Company Contact
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone_in_talk_outlined,
                              color: const Color(0xFF1B5E3F),
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Company Contact',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildContactItem(
                          Icons.email_outlined,
                          'Email',
                          profile.contactInfo.email,
                          Colors.purple.shade50,
                          Colors.purple,
                        ),
                        _buildContactItem(
                          Icons.phone_outlined,
                          'Phone',
                          profile.contactInfo.phone,
                          Colors.blue.shade50,
                          Colors.blue,
                        ),
                        _buildContactItem(
                          Icons.language_outlined,
                          'Website',
                          profile.contactInfo.website,
                          Colors.green.shade50,
                          Colors.green,
                        ),
                        _buildContactItem(
                          Icons.location_on_outlined,
                          'Location',
                          profile.contactInfo.location,
                          Colors.orange.shade50,
                          Colors.orange,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Social Media
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              color: const Color(0xFF1B5E3F),
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Social Media',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildSocialItem(
                          'Linkedin',
                          profile.socialLinks.linkedin,
                          AppIcons.linkedIn,
                        ),
                        _buildSocialItem(
                          'Twitter',
                          profile.socialLinks.twitter,
                          AppIcons.twitter,
                        ),
                        _buildSocialItem(
                          'Facebook',
                          profile.socialLinks.facebook,
                          AppIcons.facebook,
                        ),
                        _buildSocialItem(
                          'Instagram',
                          profile.socialLinks.instagram,
                          AppIcons.instagram,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Gallery
                  Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: profile.galleryImages.map((img) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(img, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String label,
    String value,
    Color bgColor,
    Color iconColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, size: 16.sp, color: iconColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialItem(String platform, String url, String iconPath) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 40.w, height: 40.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  url.replaceFirst('https://', ''),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomMenu(BuildContext context, Offset position) {
    // Calculate position to show menu relative to tap, slightly offset
    final RelativeRect positionRect = RelativeRect.fromLTRB(
      position.dx,
      position.dy + 10,
      position.dx,
      position.dy,
    );

    showMenu(
      context: context,
      position: positionRect,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 8,
      items: [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Glow Beauty Salon',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Recruiter',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              SizedBox(height: 8.h),
              Divider(color: Colors.grey.shade200),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'subscription',
          child: Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                color: Color(0xFF111827),
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    'Current: free',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(
                Icons.settings_outlined,
                color: Color(0xFF111827),
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: Divider(color: Colors.grey.shade200),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        if (value == 'logout') {
          _showLogoutConfirmationDialog(context);
        }
      }
    });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(), // Cancel
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(
                          () => const AuthScreen(),
                        ); // Navigate to Auth
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
