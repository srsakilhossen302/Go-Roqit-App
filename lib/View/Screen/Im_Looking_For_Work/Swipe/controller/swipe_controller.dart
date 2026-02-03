import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:go_roqit_app/View/Screen/Chat/view/chat_home_view.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

import '../../Home/view/home_view.dart';

class SwipeController extends GetxController {
  final AppinioSwiperController swiperController = AppinioSwiperController();
  final JobsController jobsController = Get.find<JobsController>();

  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // In a real app we might fetch specific swipe candidates
    // For now we use the job list from JobsController
  }

  void swipeLeft() {
    swiperController.swipeLeft();
  }

  // Mock profile status
  var isProfileComplete = false.obs; // Set to true to test the other flow

  void onSwipe(int previousIndex, int targetIndex, SwiperActivity activity) {
    if (activity is Swipe) {
      // Using toString check to avoid import issues with AppinioSwiperDirection
      // Checking for 'right' in case-insensitive manner just to be safe
      if (activity.direction.toString().toLowerCase().contains('right')) {
        _handleApply(previousIndex);
      }
    }
  }

  void _handleApply(int index) {
    if (isProfileComplete.value) {
      _showApplyDialog(index, startWithSuccess: true);
    } else {
      _showApplyDialog(index, startWithSuccess: false);
    }
  }

  void _showApplyDialog(int index, {required bool startWithSuccess}) {
    final RxBool showSuccess = startWithSuccess.obs;
    final JobModel job = jobsController.jobList[index];

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            if (showSuccess.value) {
              return _buildSuccessContent(job);
            } else {
              return _buildBoostContent(job, showSuccess);
            }
          }),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildBoostContent(JobModel job, RxBool showSuccess) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Color(0xFF1B5E3F),
            size: 30,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Boost Your Chances!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          "Profiles with photos and experience get more responses. You can apply now or complete your profile.",
          style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            // Switch to success view without closing dialog
            showSuccess.value = true;
          },
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 20,
          ),
          label: const Text(
            "Apply Anyway",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E3F),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            Get.back();
            Get.offAll(() => const HomeView());
          },
          icon: const Icon(
            Icons.description_outlined,
            color: Color(0xFF1B5E3F),
            size: 20,
          ),
          label: const Text(
            "Complete Profile",
            style: TextStyle(color: Color(0xFF1B5E3F)),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF1B5E3F)),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessContent(JobModel job) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Color(0xFF1B5E3F), size: 30),
        ),
        const SizedBox(height: 16),
        const Text(
          "Application Sent!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "You successfully applied for",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          job.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Job Preview Card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(job.logoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.companyName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      job.location,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        const Text(
          "Stand out! Send a message to introduce yourself.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: () {
            // Navigate to message/chat logic here if needed
            Get.to(() => ChatHomeView());
          },
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
            size: 20,
          ),
          label: const Text(
            "Send Message",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E3F),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            // Explicitly pop the dialog from the overlay navigator
            if (Get.overlayContext != null) {
              Navigator.of(Get.overlayContext!).pop();
            } else {
              Get.back();
            }
          },
          child: const Text(
            "Skip for now",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  void swipeRight() {
    swiperController.swipeRight();
    // The loop logic for manual swipe triggers the onSwipe callback too in updated libraries usually
    // If not, we might need to manually call _handleApply(currentIndex.value) here if the callback doesn't fire for manual triggers.
    // AppinioSwiper usually fires callback for manual swipes.
  }

  void onUnswipe() {
    swiperController.unswipe();
  }
}
