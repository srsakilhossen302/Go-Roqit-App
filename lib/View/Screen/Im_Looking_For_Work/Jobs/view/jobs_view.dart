import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_navigation/src/routes/transitions_type.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/job_details_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/jobs_map_view.dart';

import 'package:go_roqit_app/View/Widgegt/my_refresh_indicator.dart';

class JobsView extends StatefulWidget {
  const JobsView({super.key});

  @override
  State<JobsView> createState() => _JobsViewState();
}

class _JobsViewState extends State<JobsView> {
  final JobsController controller = Get.put(JobsController());

  @override
  void initState() {
    super.initState();
    // Fetch general jobs specifically for this view
    controller.loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: MyRefreshIndicator(
          onRefresh: () async {
            controller.loadJobs();
            await Future.delayed(const Duration(seconds: 1));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Jobs",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(
                          () => const JobsMapView(),
                          transition: Transition.fadeIn,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.map_outlined,
                          color: Colors.black,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5), // Light grey
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          onSubmitted: (value) => controller.loadJobs(),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Image.asset(
                                AppIcons.search,
                                width: 20.w,
                                height: 20.h,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Find Your Dream Job",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showFilterSheet(context),
                        icon: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B5E3F),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                // Job List
                Expanded(
                  child: Obx(() {
                    return ListView.separated(
                      itemCount: controller.jobList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final job = controller.jobList[index];
                        return _buildJobCard(job);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ), // Matches SafeArea
      bottomNavigationBar: const JobSeekerNavBar(selectedIndex: 1),
    );
  }


  Widget _buildJobCard(JobModel job) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo (Placeholder)
              CircleAvatar(
                radius: 24.r,
                backgroundImage: job.logoUrl.startsWith('http')
                    ? NetworkImage(job.logoUrl)
                    : AssetImage(AppIcons.salon)
                          as ImageProvider, // Fallback to provided asset
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(width: 12.w),
              // Job Info
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => JobDetailsView(job: job),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        job.companyName,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            job.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Chips
          Row(
            children: [
              _buildChip(
                job.jobType,
                const Color(0xFFE8F5E9),
                const Color(0xFF1B5E3F),
              ),
              SizedBox(width: 8.w),
              _buildChip(
                job.salary,
                const Color(0xFFE3F2FD),
                const Color(0xFF1E88E5),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => JobDetailsView(job: job),
                      transition: Transition.rightToLeft,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E3F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    elevation: 0,
                  ),
                  child: Text(
                    "Apply now",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search & Filter",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 15.r,
                    backgroundColor: Colors.grey[100],
                    child: const Icon(Icons.close, color: Colors.black, size: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: "Search jobs, salons, locations...",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Job Category",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            {
                              "name": "Salon Specialist",
                              "icon": AppIcons.salon,
                            },
                            {
                              "name": "Hair Stylist",
                              "icon": AppIcons.kachi,
                            },
                            {
                              "name": "Receptionist",
                              "icon": AppIcons.workOutline,
                            },
                            {
                              "name": "Salon Manager",
                              "icon": AppIcons.peopleOutline,
                            },
                          ].map((cat) {
                            String name = cat['name'] as String;
                            String icon = cat['icon'] as String;
                            bool isSelected =
                                controller.selectedCategory.value == name;

                            return GestureDetector(
                              onTap: () {
                                controller.selectedCategory.value =
                                    isSelected ? "" : name;
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 12.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFE8F5E9)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF1B5E3F)
                                        : Colors.grey.shade200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      icon,
                                      width: 18.w,
                                      height: 18.h,
                                      color: isSelected
                                          ? const Color(0xFF1B5E3F)
                                          : Colors.grey,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isSelected
                                            ? const Color(0xFF1B5E3F)
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Job Type",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            "Full-time",
                            "Part-time",
                            "Contract",
                            "Freelance",
                          ].map((type) => Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: ChoiceChip(
                                  label: Text(type),
                                  selected: controller.selectedType.value == type,
                                  onSelected: (selected) {
                                    controller.selectedType.value =
                                        selected ? type : "";
                                  },
                                  selectedColor: const Color(0xFFE8F5E9),
                                  backgroundColor: const Color(0xFFF3F4F6),
                                  labelStyle: TextStyle(
                                    color: controller.selectedType.value == type
                                        ? const Color(0xFF1B5E3F)
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                              )).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(() {
                      return Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${controller.jobList.length} jobs found",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: const Color(0xFF1B5E3F),
                              ),
                            ),
                            const Icon(
                              Icons.work_outline,
                              color: Color(0xFF1B5E3F),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          controller.searchController.clear();
                          controller.selectedCategory.value = "";
                          controller.selectedType.value = "";
                          controller.loadJobs();
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: const Text(
                          "Clear All",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.loadJobs();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: const Text(
                          "Show Results",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
