import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/controller/user_information_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Profile/UserInformation/model/user_information_model.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart'; // Import Model

class UserInformationView extends GetView<UserInformationController> {
  const UserInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserInformationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
        title: Text(
          "Personal Information",
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 4),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Obx(() {
          final model = controller.userModel.value;

          return Column(
            children: [
              // Basic Information Card
              _buildCard(
                title: "Basic Information",
                onEdit: () => _showBasicInfoSheet(context, model),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField("Full Name", model.fullName),
                    SizedBox(height: 16.h),
                    _buildField("Gender", model.gender),
                    SizedBox(height: 16.h),
                    _buildField("Date of Birth", model.dateOfBirth),
                    SizedBox(height: 16.h),
                    _buildField("Citizenship", model.citizenship),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Address Card
              _buildCard(
                title: "Address",
                onEdit: () => _showAddressSheet(context, model),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.streetAddress,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            "${model.city}, ${model.zipCode}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            model.country,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Contact Information Card
              _buildCard(
                title: "Contact Information",
                onEdit: () => _showContactSheet(context, model),
                child: Column(
                  children: [
                    _buildContactItem(
                      Icons.phone_outlined,
                      "Mobile",
                      model.mobileNumber,
                    ),
                    SizedBox(height: 16.h),
                    _buildContactItem(
                      Icons.call_outlined,
                      "Landline",
                      model.landline,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showBasicInfoSheet(BuildContext context, UserInformationModel model) {
    final firstNameController = TextEditingController(text: model.firstName);
    final lastNameController = TextEditingController(text: model.lastName);
    final genderController = TextEditingController(text: model.gender);
    final dobController = TextEditingController(text: model.dateOfBirth);
    final citizenshipController = TextEditingController(
      text: model.citizenship,
    );

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Basic Information",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              _buildTextField("First Name", firstNameController),
              SizedBox(height: 12.h),
              _buildTextField("Last Name", lastNameController),
              SizedBox(height: 12.h),
              _buildTextField("Gender", genderController),
              SizedBox(height: 12.h),
              _buildTextField("Date of Birth", dobController),
              SizedBox(height: 12.h),
              _buildTextField("Citizenship", citizenshipController),
              SizedBox(height: 20.h),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel"),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateBasicInfo(
                            firstNameController.text,
                            lastNameController.text,
                            genderController.text,
                            dobController.text,
                            citizenshipController.text,
                          );
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
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
      ),
      isScrollControlled: true,
    );
  }

  void _showAddressSheet(BuildContext context, UserInformationModel model) {
    final streetController = TextEditingController(text: model.streetAddress);
    final cityController = TextEditingController(text: model.city);
    final zipController = TextEditingController(text: model.zipCode);
    final countryController = TextEditingController(text: model.country);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Address",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              _buildTextField("Street Address", streetController),
              SizedBox(height: 12.h),
              _buildTextField("City", cityController),
              SizedBox(height: 12.h),
              _buildTextField("Zip Code", zipController),
              SizedBox(height: 12.h),
              _buildTextField("Country", countryController),
              SizedBox(height: 20.h),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel"),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateAddress(
                            streetController.text,
                            cityController.text,
                            zipController.text,
                            countryController.text,
                          );
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
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
      ),
      isScrollControlled: true,
    );
  }

  void _showContactSheet(BuildContext context, UserInformationModel model) {
    final mobileController = TextEditingController(text: model.mobileNumber);
    final landlineController = TextEditingController(text: model.landline);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Contact Info",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              _buildTextField("Mobile Number", mobileController),
              SizedBox(height: 12.h),
              _buildTextField("Landline", landlineController),
              SizedBox(height: 20.h),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel"),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateContact(
                            mobileController.text,
                            landlineController.text,
                          );
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
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
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required VoidCallback onEdit,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: const Color(0xFF1B5E3F),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1B5E3F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey.shade500, size: 20.sp),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
