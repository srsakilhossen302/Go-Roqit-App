import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/jobs_view.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/routes/transitions_type.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';

import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/nearby_jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/job_details_view.dart';

import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

import 'dart:math' as math;

import '../../../../../Utils/AppIcons/app_icons.dart';

class JobsMapView extends StatefulWidget {
  const JobsMapView({super.key});

  @override
  State<JobsMapView> createState() => _JobsMapViewState();
}

class _JobsMapViewState extends State<JobsMapView> {
  final NearbyJobsController nearbyController = Get.put(NearbyJobsController());
  final JobsController jobsController =
      Get.put(JobsController()); // Use put to ensure it's available
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  // Track map rotation
  double _currentRotation = 0.0;

  // Selected Job for bottom sheet
  final Rxn<JobModel> selectedJob = Rxn<JobModel>();

  // Filter States
  final RxString selectedJobType = "Full-time".obs;

  Widget _buildCustomMarkerWidget(String text, bool isSelected) {
    Color primaryColor = isSelected
        ? const Color(0xFF00D289)
        : const Color(0xFF1B5E3F);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pill (Distance)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // Pin Triangle (Simulated with Icon for now or Custom Paint)
        Transform.translate(
          offset: Offset(0, -5.h), // Pull up to overlap slightly
          child: Icon(
            Icons.location_on,
            size: 50.sp,
            color: primaryColor,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (nearbyController.isLoadingLocation.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF1B5E3F)),
          ),
        );
      }

      final LatLng userPosition = LatLng(
        nearbyController.userLatitude.value,
        nearbyController.userLongitude.value,
      );

      // Generate markers based on nearbyJobs
      List<Marker> currentMarkers = [];
      const Distance distance = Distance();

      for (var job in nearbyController.nearbyJobs) {
        if (job.latitude != null && job.longitude != null) {
          final double kmValue =
              job.distance ??
              (distance(userPosition, LatLng(job.latitude!, job.longitude!)) /
                  1000);

            bool isSelected = selectedJob.value?.id == job.id;

            currentMarkers.add(
              Marker(
                point: LatLng(job.latitude!, job.longitude!),
                width: isSelected
                    ? 150.w
                    : 120.w, // Slightly larger if selected
                height: 110.h,
                child: GestureDetector(
                  onTap: () {
                    selectedJob.value = job;
                  },
                  child: _buildCustomMarkerWidget(
                    "${kmValue < 0.01 && kmValue > 0 ? "0.01" : kmValue.toStringAsFixed(2)}km",
                    isSelected,
                  ),
                ),
              ),
            );
        }
      }

      // Also add User Location Marker (Blue Dot)
      currentMarkers.add(
        Marker(
          point: userPosition,
          width: 20.w,
          height: 20.h,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3.w),
              boxShadow: const [
                BoxShadow(blurRadius: 5, color: Colors.black26),
              ],
            ),
          ),
        ),
      );

      return Scaffold(
        body: Stack(
          children: [
            // 1. OpenStreetMap (Flutter Map)
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: userPosition,
                initialZoom: 12.0,
                onPositionChanged: (camera, hasGesture) {
                  if (hasGesture) {
                    setState(() {
                      _currentRotation = camera.rotation;
                    });
                  }
                },
                onTap: (_, __) {
                  // Deselect when tapping map
                  if (selectedJob.value != null) {
                    selectedJob.value = null;
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.go_roqit_app',
                ),
                MarkerLayer(markers: currentMarkers),
              ],
            ),

            // 2. Top UI Layer (SafeArea)
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  // "Jobs Near You" Header Card
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: const Color(0xFF1B5E3F),
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Jobs Near You",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "${currentMarkers.length - 1} jobs near your location", // -1 for user marker
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate back to list view
                            Get.off(
                              () => const JobsView(),
                              transition: Transition.fadeIn,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B5E3F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            minimumSize: Size.zero,
                          ),
                          child: Text(
                            "View All Job",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Search & Legend Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Search & Filter Pill
                        const Spacer(),

                        // Legend
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 4.r,
                                    backgroundColor: Colors.blue,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Your Location",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 4.r,
                                    backgroundColor: const Color(0xFF1B5E3F),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Job Location",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Bottom Controls Layer (Hidden if Job Selected)
            // We use standard 'if' because we are inside Obx
            if (selectedJob.value == null)
              Positioned(
                bottom: 150.h,
                right: 16.w,
                child: SizedBox(
                  width: 56.w,
                  height: 56.w,
                  child: FloatingActionButton(
                    onPressed: () {
                      _mapController.rotate(0);
                      _mapController.move(userPosition, 13.0);
                      setState(() {
                        _currentRotation = 0.0;
                      });
                      Get.snackbar(
                        "Locating",
                        "Moved to your location",
                        snackPosition: SnackPosition.bottom,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        margin: EdgeInsets.all(16.w),
                        duration: const Duration(seconds: 1),
                      );
                    },
                    backgroundColor: const Color(0xFF246BFD),
                    elevation: 4,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 4.w),
                    ),
                    child: Transform.rotate(
                      angle: _currentRotation * (math.pi / 180),
                      child: Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),

            // 4. Bottom Nav Bar (Hidden if Job Selected)
            if (selectedJob.value == null)
              const Align(
                alignment: Alignment.bottomCenter,
                child: JobSeekerNavBar(selectedIndex: 1),
              ),

            // 5. Job Preview Card (Shown if Job Selected)
            if (selectedJob.value != null)
              _buildJobPreviewCard(selectedJob.value!, userPosition),
          ],
        ),
      );
    });
  }


  Widget _buildJobPreviewCard(JobModel job, LatLng userPosition) {
    // Calculate distance for display
    const Distance distanceCalc = Distance();
    double meter = 0.0;
    if (job.latitude != null && job.longitude != null) {
      meter = distanceCalc(userPosition, LatLng(job.latitude!, job.longitude!));
    }
    String distStr = "${(meter / 1000).toStringAsFixed(1)}km";

    double bottomPadding = 0;
    if (Get.context != null) {
      bottomPadding = MediaQuery.of(Get.context!).padding.bottom;
    }

    return Positioned(
      bottom: 20.h + bottomPadding,
      left: 16.w,
      right: 16.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Logo, Info and Close
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(job.logoUrl),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      ),
                      color: Colors.grey[200],
                    ),
                    child: (job.logoUrl.isEmpty) ? Icon(Icons.business) : null,
                  ),
                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          job.companyName,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                "${job.location} • ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "$distStr away",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF1B5E3F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      selectedJob.value = null;
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                      ),
                      child: Icon(Icons.close, size: 20.sp, color: Colors.grey),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Row(
                children: [
                  _buildInfoChip(Icons.access_time_filled, job.jobType),
                  SizedBox(width: 8.w),
                  _buildInfoChip(
                    Icons.attach_money,
                    (job.salary.contains('/'))
                        ? job.salary.split('/')[0]
                        : (job.salary),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => JobDetailsView(job: job));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: IconButton(
                      onPressed: () =>
                          jobsController.createChat(job.recruiterId),
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        color: const Color(0xFF1B5E3F),
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: jobsController.isApplying.value
                            ? null
                            : () => jobsController.applyToJob(job.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: jobsController.isApplying.value
                            ? SizedBox(
                                height: 18.h,
                                width: 18.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.near_me,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Apply",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F7), // Light green tint
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xFF1B5E3F)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1B5E3F),
            ),
          ),
        ],
      ),
    );
  }
}
