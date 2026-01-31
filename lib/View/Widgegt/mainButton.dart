import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget mainButton({required bool loading, required VoidCallback onTap}) {
  return SizedBox(
    height: 56.h,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: loading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B5E3F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.r),
        ),
        elevation: 0,
      ),
      child: loading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              'Continue',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
    ),
  );
}

Widget termsText() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By continuing you agree to our ',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12.sp,
          fontFamily: 'Roboto', // Default font
        ),
        children: [
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(text: ' and\n'),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}
