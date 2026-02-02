import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import '../controller/business_profile_controller.dart';

class EditBusinessProfileView extends GetView<BusinessProfileController> {
  const EditBusinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Information Section
              _buildSectionHeader(Icons.business, 'Company Information'),
              SizedBox(height: 20.h),

              Text(
                'Business Logo',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Obx(() {
                      if (controller.logoPath.value != null &&
                          controller.logoPath.value!.isNotEmpty) {
                        final path = controller.logoPath.value!;
                        final isNetwork = path.startsWith('http');
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: isNetwork
                              ? Image.network(path, fit: BoxFit.cover)
                              : Image.file(File(path), fit: BoxFit.cover),
                        );
                      }
                      return Icon(
                        Icons.business,
                        size: 30.sp,
                        color: Colors.grey,
                      );
                    }),
                  ),
                  SizedBox(width: 16.w),
                  ElevatedButton.icon(
                    onPressed: controller.pickLogo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                    icon: Icon(Icons.file_upload_outlined, size: 18.sp),
                    label: Text(
                      'Upload Logo',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'SVG, PNG, JPG (max. 400x400px)',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),

              SizedBox(height: 24.h),
              _buildTextField(
                label: 'Business Name *',
                hint: 'e.g. Glow Beauty Salon',
                controller: controller.nameController,
              ),
              _buildTextField(
                label: 'Business Type *',
                hint: 'e.g. Beauty Salon',
                controller: controller.categoryController,
              ),
              _buildTextField(
                label: 'Company Description *',
                hint: 'Describe your company...',
                controller: controller.descriptionController,
                maxLines: 4,
              ),
              _buildTextField(
                label: 'Company Email *',
                hint: 'e.g. contact@company.com',
                controller: controller.emailController,
                iconOriginal: Icons.email_outlined,
              ),
              _buildTextField(
                label: 'Company Phone *',
                hint: 'e.g. +44 20 7946 0123',
                controller: controller.phoneController,
                iconOriginal: Icons.phone_outlined,
              ),
              _buildTextField(
                label: 'Website',
                hint: 'https://example.com',
                controller: controller.websiteController,
                iconOriginal: Icons.language_outlined,
              ),
              _buildTextField(
                label: 'Location *',
                hint: 'e.g. London, UK',
                controller: controller.locationController,
                iconOriginal: Icons.location_on_outlined,
              ),

              SizedBox(height: 32.h),

              // Social Media Section
              Center(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade500, // Instagram color approx
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Social Media',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 30.h),

              _buildTextField(
                label: 'LinkedIn',
                hint: 'https://linkedin.com/company/name',
                controller: controller.linkedinController,
                iconPath: AppIcons.linkedInIcons,
              ),
              _buildTextField(
                label: 'Twitter',
                hint: 'https://twitter.com/handle',
                controller: controller.twitterController,
                iconPath: AppIcons.twitterIcons,
              ),
              _buildTextField(
                label: 'Facebook',
                hint: 'https://facebook.com/page',
                controller: controller.facebookController,
                iconPath: AppIcons.facebookIcons,
              ),
              _buildTextField(
                label: 'Instagram',
                hint: 'https://instagram.com/handle',
                controller: controller.instagramController,
                iconPath: AppIcons.instagramIcons,
              ),

              SizedBox(height: 32.h),

              // Gallery Section
              Text(
                'Gallery',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                // Ensure exactly 3 items
                final galleryItems = controller.galleryImages.take(3).toList();
                final int neededPlaceholders = 3 - galleryItems.length;

                return Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [
                    ...galleryItems.map((img) => _buildGalleryItem(img)),
                    for (int i = 0; i < neededPlaceholders; i++)
                      _buildAddGalleryItem(),
                  ],
                );
              }),

              SizedBox(height: 40.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Save Changes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.blue, // Approx color from design
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    IconData? iconOriginal,
    String? iconPath,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14.sp,
              ),
              prefixIcon: iconPath != null
                  ? Transform.scale(
                      scale: 0.6, // Adjust scale if needed
                      child: Image.asset(iconPath),
                    )
                  : (iconOriginal != null
                        ? Icon(iconOriginal, color: Colors.grey, size: 20.sp)
                        : null),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
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
                borderSide: const BorderSide(color: Color(0xFF1B5E3F)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(String imageUrl) {
    final isNetwork = imageUrl.startsWith('http');
    return GestureDetector(
      onTap: controller.pickGalleryImage,
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            image: isNetwork
                ? NetworkImage(imageUrl)
                : FileImage(File(imageUrl)) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAddGalleryItem() {
    return GestureDetector(
      onTap: controller.pickGalleryImage,
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Icon(Icons.add, color: Colors.grey, size: 30.sp),
        ),
      ),
    );
  }
}
