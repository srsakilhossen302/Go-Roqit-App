import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/business_profile_controller.dart';

class BusinessProfileView extends GetView<BusinessProfileController> {
  const BusinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BusinessProfileController());

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
          'Step 2 of 3',
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
                flex: 2,
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
              'Business profile',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Help professionals find you",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 32.h),

            // 1. Business Type
            Text(
              'Business type',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 3.5,
              ),
              itemCount: controller.businessTypes.length,
              itemBuilder: (context, index) {
                final type = controller.businessTypes[index];
                return Obx(() {
                  final isSelected =
                      controller.selectedBusinessType.value == type;
                  return GestureDetector(
                    onTap: () => controller.selectBusinessType(type),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1B5E3F)
                              : Colors.grey.shade300,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isSelected
                              ? const Color(0xFF1B5E3F)
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),

            SizedBox(height: 24.h),

            // 2. About your salon
            Text(
              'About your salon',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: TextField(
                controller: controller.aboutController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Describe your salon, atmosphere, clientele...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // 3. Gallery (Updated with Dialog/BottomSheet)
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  final imagePath = controller.galleryImages[index];
                  return GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          color: Colors.white,
                          child: SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Camera'),
                                  onTap: () {
                                    controller.pickImage(
                                      index,
                                      ImageSource.camera,
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Gallery'),
                                  onTap: () {
                                    controller.pickImage(
                                      index,
                                      ImageSource.gallery,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade300),
                        image: imagePath != null
                            ? DecorationImage(
                                image: FileImage(File(imagePath)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imagePath == null
                          ? Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey[500],
                                size: 24.sp,
                              ),
                            )
                          : null,
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 48.h),

            // Continue Button
            SafeArea(
              child: Obx(
                () => mainButton(
                  loading: controller.isLoading.value,
                  text: 'Continue',
                  onTap: controller.submitBusinessProfile,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
