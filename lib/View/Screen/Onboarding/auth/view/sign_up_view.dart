import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/controller/sign_up_controller.dart';
import 'package:go_roqit_app/View/Screen/Onboarding/auth/view/auth_screen.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:go_roqit_app/View/Widgegt/textField.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter your details to sign up",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 32.h),

            // Form Fields
            textField('Full Name', controller.fullName, hintText: 'Your Name'),
            SizedBox(height: 16.h),
            textField(
              'Email',
              controller.signUpEmail,
              hintText: 'your@email.com',
            ),
            SizedBox(height: 16.h),
            textField(
              'Password',
              controller.signUpPassword,
              obscure: true,
              hintText: 'Create a password',
            ),
            SizedBox(height: 32.h),

            // Sign Up Button
            Obx(
              () => mainButton(
                loading: controller.isLoading.value,
                onTap: controller.signUp,
                text: "Sign Up",
              ),
            ),
            SizedBox(height: 24.h),

            // Already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate back to the start of Auth flow (SignIn)
                    Get.offAll(() => const AuthScreen());
                  },
                  child: Text(
                    "Sign In",
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
