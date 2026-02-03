import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/routes/transitions_type.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Chat/view/chat_home_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Home/view/home_view.dart';

// Placeholder views for navigation
class JobsPlaceholderView extends StatelessWidget {
  const JobsPlaceholderView({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text("Jobs Page")));
}

class SwipePlaceholderView extends StatelessWidget {
  const SwipePlaceholderView({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text("Swipe Page")));
}

class ProfilePlaceholderView extends StatelessWidget {
  const ProfilePlaceholderView({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text("Profile Page")));
}

class JobSeekerNavBar extends StatelessWidget {
  final int selectedIndex;

  const JobSeekerNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 100
            .h, // Allocate enough height for the floating button without clipping
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: AppIcons.salon,
                    label: 'Home',
                    onTap: () {
                      if (selectedIndex != 0) {
                        Get.off(
                          () => const HomeView(),
                          transition: Transition.fadeIn,
                        );
                      }
                    },
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: AppIcons.workOutline,
                    label: 'Jobs',
                    onTap: () {
                      if (selectedIndex != 1) {
                        Get.off(
                          () => const JobsPlaceholderView(),
                          transition: Transition.fadeIn,
                        );
                      }
                    },
                  ),
                  SizedBox(width: 48.w), // Spacer for the floating button
                  _buildNavItem(
                    index: 3,
                    icon: AppIcons.message,
                    label: 'Messages',
                    onTap: () {
                      if (selectedIndex != 3) {
                        Get.off(
                          () => const ChatHomeView(),
                          transition: Transition.fadeIn,
                        );
                      }
                    },
                  ),
                  _buildNavItem(
                    index: 4,
                    icon: AppIcons.peopleOutline,
                    label: 'Profile',
                    onTap: () {
                      if (selectedIndex != 4) {
                        Get.off(
                          () => const ProfilePlaceholderView(),
                          transition: Transition.fadeIn,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30.h, // Lift it up
              child: _buildSwipeItem(
                index: 2,
                onTap: () {
                  if (selectedIndex != 2) {
                    Get.off(
                      () => const SwipePlaceholderView(),
                      transition: Transition.fadeIn,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedIndex == index;
    final Color selectedColor = const Color(0xFF1B5E3F);
    final Color unselectedColor = Colors.grey;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            height: 24.h,
            width: 24.w,
            color: isSelected ? selectedColor : unselectedColor,
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? selectedColor : unselectedColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeItem({required int index, required VoidCallback onTap}) {
    // Swipe button is special (Active or Inactive, keeping design consistent)
    // The design shows a green circle with white heart.
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48.h,
            width: 48.w,
            decoration: const BoxDecoration(
              color: Color(0xFF91B4A2), // Muted green
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(12.w),
            child: Image.asset(AppIcons.love, color: Colors.white),
          ),
          SizedBox(height: 6.h),
          Text(
            "Swipe",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
              color: Colors
                  .grey, // Text is grey in design even if button is highlighted?
              // Actually in design text looks grey. Keeping it grey.
            ),
          ),
        ],
      ),
    );
  }
}
