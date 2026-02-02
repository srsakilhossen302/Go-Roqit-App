import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Im_Hiring_For_My_Salon/Recruiter_Panel/view/recruiter_panel_view.dart';
import '../Screen/Im_Hiring_For_My_Salon/Job_Posts/view/job_posts_view.dart';
import '../Screen/Im_Hiring_For_My_Salon/Applications/view/applications_view.dart';
// Import other views when created

class HiringNavBar extends StatelessWidget {
  final int selectedIndex;

  const HiringNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80.h,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              icon: AppIcons.overviewNav,
              label: 'Overview',
              onTap: () {
                if (selectedIndex != 0)
                  Get.off(
                    () => const RecruiterPanelView(),
                    transition: Transition.fadeIn,
                  );
              },
            ),
            _buildNavItem(
              index: 1,
              icon: AppIcons.jobsNav,
              label: 'Jobs',
              onTap: () {
                if (selectedIndex != 1)
                  Get.off(
                    () => const JobPostsView(),
                    transition: Transition.fadeIn,
                  );
              },
            ),
            _buildNavItem(
              index: 2,
              icon: AppIcons.applicationsNav,
              label: 'Applications',
              onTap: () {
                if (selectedIndex != 2)
                  Get.off(
                    () => const ApplicationsView(),
                    transition: Transition.fadeIn,
                  );
              },
            ),
            _buildNavItem(
              index: 3,
              icon: AppIcons.message,
              label: 'Messages',
              onTap: () {
                // Get.off(() => MessagesView(), transition: Transition.fadeIn);
                if (selectedIndex != 3) print("Navigate to Messages");
              },
            ),
            _buildNavItem(
              index: 4,
              icon: AppIcons.businessNav,
              label: 'Business',
              onTap: () {
                // Get.off(() => BusinessView(), transition: Transition.fadeIn);
                if (selectedIndex != 4) print("Navigate to Business");
              },
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* 
             NOTE: Using IconData for now to prevent crashes. 
             To use AppIcons assets, swap Icon() with Image.asset().
          */
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
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? selectedColor : unselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}
