import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/controller/sign_in_controller.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/controller/sign_up_controller.dart';

import '../controller/auth_controller.dart';
import 'sign_in_view.dart';
import 'sign_up_view.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject dependencies
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    final controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Image.asset(AppIcons.backIcons),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              'Create account',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Get started as a professional',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 32.h),

            /// TAB BAR (Underline Style)
            Obx(
              () => Row(
                children: [
                  _buildTab(
                    'Sign in',
                    controller.isSignIn.value,
                    () => controller.switchTab(true),
                  ),
                  _buildTab(
                    'Create account',
                    !controller.isSignIn.value,
                    () => controller.switchTab(false),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            /// BODY SWITCH
            Obx(
              () => controller.isSignIn.value
                  ? const SignInView()
                  : const SignUpView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                text,
                style: TextStyle(
                  color: active ? Colors.black : Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 2.h,
              width: double.infinity,
              color: active ? Color(0xFF1B5E3F) : Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }
}
