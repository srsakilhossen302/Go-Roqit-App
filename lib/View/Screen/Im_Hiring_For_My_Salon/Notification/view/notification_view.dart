import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';
import 'package:go_roqit_app/Utils/AppIcons/app_icons.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());

    return Scaffold(
      bottomNavigationBar: const HiringNavBar(selectedIndex: 0),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0, // Custom header in body
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1B5E3F),
                        ),
                      ),
                      Obx(
                        () => Text(
                          '${controller.unreadCount.value} unread',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: controller.markAllAsRead,
                    child: Text(
                      'Mark all as read',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B5E3F),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Filter Tab "All (8)"
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 1.h),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: const Color(0xFF1B5E3F),
                            width: 2.h,
                          ),
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          'All (${controller.notifications.length})',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1B5E3F),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Notification List
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    itemCount: controller.notifications.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return _buildNotificationItem(
                        controller.notifications[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Subtle shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Accent Line for Unread
              if (notification.isUnread)
                Container(
                  width: 3.w,
                  height: 48.h, // Approx height
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B5E3F),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),

              // Icon with Circle
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.green.shade50.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: _getIconForType(notification.type),
              ),
              SizedBox(width: 12.w),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            notification.title == 'Review Reminder' ||
                                notification.title == 'Booking Confirmed'
                            ? const Color(0xFF1B5E3F)
                            : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification.description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      notification.time,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Dismiss Button
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => controller.removeNotification(notification.id),
              child: Icon(
                Icons.close,
                size: 16.sp,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconForType(NotificationType type) {
    // Mapping internal types to UI icons.
    // Using simple icons for now, can swap with Images from AppIcons if needed.
    switch (type) {
      case NotificationType.booking:
        return Icon(
          Icons.calendar_today_outlined,
          color: const Color(0xFF1B5E3F),
          size: 18.sp,
        );
      case NotificationType.message:
        return Icon(
          Icons.chat_bubble_outline,
          color: const Color(0xFF1B5E3F),
          size: 18.sp,
        );
      case NotificationType.reminder:
        return Icon(
          Icons.star_outline,
          color: const Color(0xFF1B5E3F),
          size: 18.sp,
        );
      case NotificationType.payment:
        return Icon(
          Icons.check_circle_outline,
          color: const Color(0xFF1B5E3F),
          size: 18.sp,
        );
    }
  }
}
