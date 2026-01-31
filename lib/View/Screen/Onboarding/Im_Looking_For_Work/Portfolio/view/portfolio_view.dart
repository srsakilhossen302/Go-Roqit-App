import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:go_roqit_app/View/Widgegt/textField.dart';
import '../controller/portfolio_controller.dart';

class PortfolioView extends GetView<PortfolioController> {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PortfolioController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AppIcons.backIcons),
          ),
        ),
        title: Text(
          'Step 5 of 6',

          ///jasjd
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.h),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(height: 2.h, color: const Color(0xFF1B5E3F)),
              ),
              Expanded(
                flex: 1,
                child: Container(height: 2.h, color: Colors.grey[200]),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Portfolio',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 24.h),

            // Portfolio Entry Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload Images',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Container(
                      height: 120.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_file_outlined,
                            size: 32.sp,
                            color: Colors.grey[500],
                          ),
                          SizedBox(height: 8.h),
                          Obx(
                            () => Text(
                              controller.uploadedFileName.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  textField(
                    'Title',
                    controller.titleController,
                    hintText: 'Enter portfolio title',
                  ),
                  SizedBox(height: 16.h),

                  // Description Field (Multi-line)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          color: const Color(0xFF1A1A1A),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: controller.descriptionController,
                        maxLines: 4,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Write a short description',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFCFCFD),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF1B5E3F),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 48.h,
                    width: 150.w,
                    child: ElevatedButton(
                      onPressed: controller.addPortfolio,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B5E3F),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: Text(
                        'Add Portfolio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // Bottom Buttons (Skip | Continue)
            SafeArea(
              child: Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: controller.skipStep,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Obx(
                      () => mainButton(
                        loading: controller.isLoading.value,
                        text: 'Continue',
                        onTap: controller.submitPortfolio,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
