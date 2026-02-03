import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get_x/get_core/src/get_main.dart';
import 'package:get_x/get_instance/src/extension_instance.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_navigation/src/extension_navigation.dart';
import 'package:get_x/get_navigation/src/snackbar/snackbar.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/controller/jobs_controller.dart';
import 'package:go_roqit_app/View/Screen/Im_Looking_For_Work/Jobs/model/job_model.dart';

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

  void swipeRight() {
    swiperController.swipeRight();
  }

  void onSwipe(int previousIndex, int targetIndex, SwiperActivity activity) {
    // Basic logic based on direction if activity exposes it
    if (activity is Swipe) {
      // Using toString check to avoid import issues with AppinioSwiperDirection
      if (activity.direction.toString() == 'AppinioSwiperDirection.right') {
        Get.snackbar(
          "Applied",
          "You applied for ${jobsController.jobList[previousIndex].title}",
          snackPosition: SnackPosition.top,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
    }
  }

  void onUnswipe() {
    swiperController.unswipe();
  }
}
