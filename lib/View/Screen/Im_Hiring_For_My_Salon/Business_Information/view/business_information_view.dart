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
import '../controller/business_information_controller.dart';

class BusinessInformationView extends GetView<BusinessInformationController> {
  const BusinessInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BusinessInformationController());

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
          'Step 1 of 3',
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
                flex: 1,
                child: Container(height: 2.h, color: const Color(0xFF1B5E3F)),
              ),
              Expanded(
                flex: 2,
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
              'Business basics',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Tell us about your salon",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 32.h),

            // Form Fields
            textField(
              'Business name',
              controller.businessNameController,
              hintText: 'Enter salon name',
            ),
            SizedBox(height: 16.h),
            textField(
              'Contact name',
              controller.contactNameController,
              hintText: 'Your name',
            ),
            SizedBox(height: 16.h),
            textField(
              'Phone number',
              controller.phoneNumberController,
              hintText: 'Enter phone number',
            ),
            SizedBox(height: 16.h),

            // Address with "Use current location"
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textField(
                  'Address',
                  controller.addressController,
                  hintText: 'Street address, city, postcode',
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: controller.useCurrentLocation,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.sp,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Use current location',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 48.h),

            // Continue Button
            Obx(
              () => mainButton(
                loading: controller.isLoading.value,
                text: 'Continue',
                onTap: controller.submitBusinessInfo,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
