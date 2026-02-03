import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_state_manager/src/simple/get_view.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Widgegt/mainButton.dart';
import 'package:go_roqit_app/View/Widgegt/textField.dart';
import '../controller/personal_information_controller.dart';

class PersonalInformationView extends GetView<PersonalInformationController> {
  const PersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PersonalInformationController());

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
          'Step 1 of 6',
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
                flex: 5,
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
              'Personal Information',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Let's build your professional profile",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 32.h),

            // Profile Photo Upload
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.w),
                      child: SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () {
                                controller.pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Gallery'),
                              onTap: () {
                                controller.pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Obx(() {
                      final path = controller.profileImagePath.value;
                      return Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300]!),
                          image: path.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(
                                    // Assuming dart:io is imported or will be.
                                    // Wait, I need to check imports.
                                    // Assuming I need to import dart:io.
                                    // I'll add "import 'dart:io';" to the file if needed in a separate step or here if I can.
                                    // But I can't modify imports here.
                                    // I'll rely on File from dart:io.
                                    // If dart:io isn't imported, I'll get an error.
                                    // Checking imports... step 709 showed NO dart:io.
                                    // I should add it first or use a work around? No valid workaround for FileImage(File(path)) without dart:io.
                                    // I'll proceed and then fix the missing import.
                                    // Actually, I can use a separate ReplaceFileContent for import.
                                    // Wait, I can try to use standard Image.file but that also needs File.
                                    // Okay I will let the lint catch it and fix it.
                                    // Actually, let's just make it compilable by assuming I'll fix it.
                                    // BUT, I can check if I can add it now. No, the tool is single block.
                                    // I'll do this replacement, then fix import.
                                    File(path),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: path.isEmpty
                            ? Icon(
                                Icons.camera_alt_outlined,
                                size: 32.sp,
                                color: Colors.grey[500],
                              )
                            : null,
                      );
                    }),
                    SizedBox(height: 12.h),
                    Text(
                      'Upload profile photo',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Names
            Row(
              children: [
                Expanded(
                  child: textField(
                    'First Name *',
                    controller.firstNameController,
                    hintText: 'John',
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: textField(
                    'Last Name *',
                    controller.lastNameController,
                    hintText: 'Doe',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Gender
            Text(
              'Gender *',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: controller.genderOptions.map((gender) {
                return Obx(() {
                  final isSelected = controller.selectedGender.value == gender;
                  return GestureDetector(
                    onTap: () => controller.selectGender(gender),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      width:
                          MediaQuery.of(context).size.width / 2 -
                          32.w, // Approximate half width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1B5E3F)
                              : Colors.grey[200]!,
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Center(
                        child: Text(
                          gender,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF1B5E3F)
                                : Colors.grey[600],
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
            SizedBox(height: 16.h),

            // Date of Birth
            GestureDetector(
              onTap: () => controller.selectDate(context),
              child: AbsorbPointer(
                child: Obx(
                  () => textField(
                    'Date of Birth *',
                    TextEditingController(
                      text: controller.selectedDateOfBirth.value,
                    ),
                    hintText: 'YYYY-MM-DD',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Citizenship
            textField('Citizenship *', controller.citizenshipController),
            SizedBox(height: 32.h),

            // Address Details
            Text(
              'Address Details',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 16.h),
            textField(
              'Street Address *',
              controller.streetAddressController,
              hintText: '123 Main Street',
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: textField(
                    'City *',
                    controller.cityController,
                    hintText: 'London',
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: textField(
                    'Zip/Postal Code *',
                    controller.zipCodeController,
                    hintText: 'SW1A 1AA',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            textField('Country *', controller.countryController),

            SizedBox(height: 32.h),

            // Contact Info
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 16.h),
            textField(
              'Mobile Number *',
              controller.mobileNumberController,
              hintText: '+44 7123 456789',
            ),
            SizedBox(height: 16.h),
            textField(
              'Landline (Optional)',
              controller.landlineController,
              hintText: '+44 20 1234 5678',
            ),

            SizedBox(height: 40.h),

            // Buttons
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
                        onTap: controller.submitPersonalInformation,
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
