import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';

import 'OnboardingData.dart';
import 'OnboardingPage.dart';
import '../RolScreen/WelcomeScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: Icons.search,
      title: 'Find Work Fast',
      description:
          'Find jobs curated specifically for\nyour skills and experience',
      imagePath: 'assets/images/Find Work Fast.png', // Replace with your image
    ),
    OnboardingData(
      icon: Icons.favorite,
      title: 'Swipe to Apply',
      description:
          'Swipe right to apply instantly, left to\nskip - it\'s that simple',
      imagePath: 'assets/images/Swipe to Apply.png', // Replace with your image
    ),
    OnboardingData(
      icon: Icons.chat_bubble_outline,
      title: 'Track & Connect',
      description: 'Track your applications and chat\ndirectly with recruiters',
      imagePath: 'assets/images/Track & Connect.png', // Replace with your image
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 24.w, top: 16.h),
                child: TextButton(
                  onPressed: () {
                   Get.offAll(()=> WelcomeScreen());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFE8F5E9), // Light green bg
                    foregroundColor: const Color(0xFF1B5E3F), // Dark green text
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: _pages[index]);
                },
              ),
            ),

            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 8.h,
                  width: _currentPage == index ? 24.w : 8.w,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF1B5E3F)
                        : const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Next button
            // Next button
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: SizedBox(
                width: 160.w, // Fixed width for pill shape
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Get.offAll(()=> WelcomeScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFF1B5E3F).withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
