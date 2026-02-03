import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/controller/sign_in_controller.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/RolScreen/WelcomeScreen.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:go_roqit_app/View/Widgegt/textField.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Check if we can go back, otherwise maybe exit app or go to onboarding
            if (Get.previousRoute.isNotEmpty) {
              Get.back();
            }
          },
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
          ), // Using default icon if AppIcons.backIcons requires context/assets not ready
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter your details to sign in",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 32.h),

            // Email
            textField(
              'Email',
              controller.signInEmail,
              hintText: 'your@email.com',
            ),
            SizedBox(height: 16.h),

            // Password
            textField(
              'Password',
              controller.signInPassword,
              obscure: true,
              hintText: 'Enter your password',
            ),
            SizedBox(height: 32.h),

            // Sign In Button
            Obx(
              () => mainButton(
                loading: controller.isLoading.value,
                onTap: controller.signIn,
                text: "Sign In",
              ),
            ),
            SizedBox(height: 24.h),

            // Don't have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const WelcomeScreen());
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1B5E3F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Center(child: termsText()),
          ],
        ),
      ),
    );
  }
}
