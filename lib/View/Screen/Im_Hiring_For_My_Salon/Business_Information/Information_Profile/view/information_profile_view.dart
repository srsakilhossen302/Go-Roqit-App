import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import '../controller/information_profile_controller.dart';

class InformationProfileView extends GetView<InformationProfileController> {
  const InformationProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller if not already present (for testing isolation)
    if (!Get.isRegistered<InformationProfileController>()) {
      Get.put(InformationProfileController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Business profile',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Help professionals find you',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 30.h),

                    // Business Type Section
                    Text(
                      'Business type',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildBusinessTypeGrid(),

                    SizedBox(height: 30.h),

                    // About Section
                    Text(
                      'About your salon',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: controller.aboutController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            'Describe your salon, atmosphere, clientele...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF1B5E3F),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Gallery Section
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildGalleryGrid(),

                    SizedBox(height: 100.h), // Space for button
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20.sp),
                onPressed: () => Get.back(),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Step 2 of 3',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40.w), // Balance back button
            ],
          ),
        ),
        // Progress Bar
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4.h,
                color: const Color(0xFF1B5E3F), // Active step color (Green)
              ),
            ),
            Expanded(
              flex: 1, // Remaining steps
              child: Container(height: 4.h, color: Colors.grey.shade200),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessTypeGrid() {
    return Obx(() {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 3, // Adjust for button height
        children: controller.businessTypes.map((type) {
          final isSelected = controller.selectedBusinessType.value == type;
          return GestureDetector(
            onTap: () => controller.selectBusinessType(type),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1B5E3F)
                      : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? const Color(0xFF1B5E3F)
                        : const Color(0xFF111827),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildGalleryGrid() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          if (index < controller.galleryImages.length) {
            // Display Image
            return _buildImageItem(index, controller.galleryImages[index]);
          } else {
            // Display Add Button
            return _buildAddButton();
          }
        }),
      );
    });
  }

  Widget _buildImageItem(int index, String path) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => controller.removeImage(index),
            child: CircleAvatar(
              radius: 10.r,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 14.sp, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: controller.pickGalleryImage,
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6), // Light grey background
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Icon(Icons.add, color: Colors.grey, size: 30.sp),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: Obx(
          () => ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : controller.onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E3F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 0,
            ),
            child: controller.isLoading.value
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
