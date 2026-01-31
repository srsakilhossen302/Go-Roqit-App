import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'OnboardingData.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image container with icon overlay
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // Image
              Container(
                width: double.infinity,
                height: 384.h, // Dynamic height using ScreenUtil
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  image: DecorationImage(
                    image: AssetImage(data.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                // Add a bottom margin to the container itself if needed?
                // No, the transform will push the icon out.
              ),

              // Icon overlay using Transform.translate
              Transform.translate(
                offset: Offset(
                  0,
                  -30.h,
                ), // Move down by half the icon height (56/2)
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B5E3F),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Image.asset(data.icon, color: Colors.white),
                ),
              ),
            ],
          ),

          SizedBox(height: 30.h), // Space for icon overlap + visual gap
          // Title
          Text(
            data.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff111827),
              // letterSpacing: -0.5,
            ),
            // textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff111827),
              // height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
