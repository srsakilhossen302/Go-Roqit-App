import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_navigation/src/routes/transitions_type.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';

import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/jobs_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/view/job_details_view.dart';

import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';
import 'dart:math' as math;

class JobsMapView extends StatefulWidget {
  const JobsMapView({super.key});

  @override
  State<JobsMapView> createState() => _JobsMapViewState();
}

class _JobsMapViewState extends State<JobsMapView> {
  final JobsController jobsController = Get.put(JobsController());
  final MapController _mapController = MapController();

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
            // Handle Bar
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

            // Header
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
                    child: Icon(Icons.close, color: Colors.black, size: 18.sp),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Search Box
            TextField(
              decoration: InputDecoration(
                hintText: "Search jobs, salons, locations...",
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
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

            // Job Type
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
                  children: ["Full-time", "Part-time", "Contract", "Freelance"]
                      .map(
                        (type) => Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ChoiceChip(
                            label: Text(type),
                            selected: selectedJobType.value == type,
                            onSelected: (selected) {
                              if (selected) selectedJobType.value = type;
                            },
                            selectedColor: const Color(
                              0xFFE8F5E9,
                            ), // Light green bg
                            backgroundColor: const Color(0xFFF3F4F6),
                            labelStyle: TextStyle(
                              color: selectedJobType.value == type
                                  ? const Color(0xFF1B5E3F)
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            // Start Hack to remove boarder
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            // End Hack
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Distance",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${_selectedDistance}km",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B5E3F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            StatefulBuilder(
              builder: (context, setSheetState) {
                return Row(
                  children: [20, 50, 100].map((dist) {
                    bool isSelected = _selectedDistance == dist;
                    return Expanded(
                      // Evenly distribute
                      child: GestureDetector(
                        onTap: () {
                          setSheetState(() {
                            _selectedDistance = dist;
                          });
                          setState(() {}); // Update parent UI too
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1B5E3F)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "${dist}km",
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            SizedBox(height: 24.h),

            // Summary Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Light green
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "5 jobs found", // Dynamic ideally
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: const Color(0xFF1B5E3F),
                        ),
                      ),
                      Text(
                        "Showing results within ${_selectedDistance}km",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: const Color(0xFF1B5E3F),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Bottom Buttons
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {}, // Logic to clear
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          "Clear All",
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
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E3F),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "Show Results",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (jobsController.isLoadingLocation.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF1B5E3F)),
          ),
        );
      }

      final LatLng userPosition = LatLng(
        jobsController.userLatitude.value,
        jobsController.userLongitude.value,
      );

      // Generate markers based on current jobList and selected filter
      List<Marker> currentMarkers = [];
      const Distance distance = Distance();

      for (var job in jobsController.jobList) {
        if (job.latitude != null && job.longitude != null) {
          final double meter = distance(
            userPosition,
            LatLng(job.latitude!, job.longitude!),
          );
          double km = meter / 1000;

          if (km <= _selectedDistance) {
            bool isSelected = selectedJob.value?.id == job.id;

            currentMarkers.add(
              Marker(
                point: LatLng(job.latitude!, job.longitude!),
                width: isSelected
                    ? 150.w
                    : 120.w, // Slightly larger if selected
                height: 80.h,
                child: GestureDetector(
                  onTap: () {
                    selectedJob.value = job;
                  },
                  child: _buildCustomMarkerWidget(
                    "${km.toStringAsFixed(1)}km",
                    isSelected,
                  ),
                ),
              ),
            );
          }
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
                              "${currentMarkers.length - 1} jobs within ${_selectedDistance}km", // -1 for user marker
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
                        GestureDetector(
                          onTap: () {
                            _showFilterSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.filter_list,
                                  color: const Color(0xFF1B5E3F),
                                  size: 20.sp,
                                ), // Or funnel icon
                                SizedBox(width: 8.w),
                                Text(
                                  "Search & Filter",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

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
                bottom: 150.h, // Space for Bottom Nav Bar + FAB
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Distribute space
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Distance Selector
                    Container(
                      padding: EdgeInsets.all(12.w),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Distance",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              _buildDistanceChip("20km", 20),
                              SizedBox(width: 8.w),
                              _buildDistanceChip("50km", 50),
                              SizedBox(width: 8.w),
                              _buildDistanceChip("100km", 100),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // FAB (Location / Navigation)
                    SizedBox(
                      width: 56.w,
                      height: 56.w,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Reset rotation and move to location
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
                  ],
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

  int _selectedDistance = 20;

  Widget _buildDistanceChip(String text, int distance) {
    bool isSelected = _selectedDistance == distance;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDistance = distance;
          // Here you would typically filter the map markers or zoom
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B5E3F) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
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
                        image: NetworkImage(job.logoUrl ?? ""),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      ),
                      color: Colors.grey[200],
                    ),
                    child: (job.logoUrl == null || job.logoUrl!.isEmpty)
                        ? Icon(Icons.business)
                        : null,
                  ),
                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title ?? "Job Title",
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
                          job.companyName ?? "Company",
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
                  _buildInfoChip(
                    Icons.access_time_filled,
                    job.jobType ?? "Full-time",
                  ),
                  SizedBox(width: 8.w),
                  _buildInfoChip(
                    Icons.attach_money,
                    (job.salary != null && job.salary!.contains('/'))
                        ? job.salary!.split('/')[0]
                        : (job.salary ?? "Salary"),
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
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply Logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B5E3F),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Apply Now",
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
