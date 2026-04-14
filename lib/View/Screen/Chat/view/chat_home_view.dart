import 'package:flutter/material.dart';
import 'package:go_roqit_app/View/Widgegt/my_refresh_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Chat/controller/chat_controller.dart';
import 'package:go_roqit_app/View/Screen/Chat/model/chat_model.dart';
import 'package:go_roqit_app/View/Screen/Chat/view/chat_details_view.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';
import 'package:go_roqit_app/View/Widgegt/JobSeekerNavBar.dart';

import 'package:go_roqit_app/helper/shared_prefe/shared_prefe.dart';
import 'package:go_roqit_app/service/api_url.dart';

class ChatHomeView extends GetView<ChatController> {
  const ChatHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: FutureBuilder<String>(
        // Use the correct key from SharedPreferenceValue
        future: SharePrefsHelper.getString(SharedPreferenceValue.role),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          // Check if user role is 'recruiter'
          final isRecruiter = snapshot.data == 'recruiter';
          if (isRecruiter) {
            return const HiringNavBar(selectedIndex: 3);
          }
          // Default to Job Seeker
          return const JobSeekerNavBar(selectedIndex: 3);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Messages',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
              ),
              SizedBox(height: 16.h),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r), // Rounded
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: const BorderSide(color: Color(0xFF1B5E3F)),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),

              SizedBox(height: 20.h),

              // Chat List
              Expanded(
                child: Obx(() {
                  return MyRefreshIndicator(
                    onRefresh: controller.refreshChats,
                    child: ListView.separated(
                      itemCount: controller.chatList.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey.shade100),
                      itemBuilder: (context, index) {
                        return _buildChatItem(controller.chatList[index]);
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(ChatListModel chat) {
    // Identify the other participant (not me)
    Participant other = chat.participants.firstWhere(
      (p) => p.id != controller.myId.value,
      orElse: () => chat.participants.isNotEmpty 
          ? chat.participants.first 
          : Participant(id: '', email: '', name: 'Unknown', image: ''),
    );

    String name = other.name;
    String imageUrl = other.image.startsWith('http') 
        ? other.image 
        : "${ApiUrl.IMGUrl}${other.image}";
    String lastMsg = chat.lastMessage?.text ?? "No messages yet";
    String time = "";
    
    if (chat.lastMessage != null) {
      final diff = DateTime.now().difference(chat.lastMessage!.createdAt);
      if (diff.inDays > 0) {
        time = "${diff.inDays}d ago";
      } else if (diff.inHours > 0) {
        time = "${diff.inHours}h ago";
      } else if (diff.inMinutes > 0) {
        time = "${diff.inMinutes}m ago";
      } else {
        time = "just now";
      }
    }

    bool isRead = true; // status field in API might mean something else, setting true for now

    return InkWell(
      onTap: () {
        // Start polling messages for this chat
        controller.startPollingMessages(chat.id);
        Get.to(() => ChatDetailsView(chat: chat))?.then((_) {
          // Stop polling when returning to chat list
          controller.stopPollingMessages();
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.grey.shade200,
                  onBackgroundImageError: (_, __) {
                    // Fallback to placeholder if image fails to load
                  },
                ),
                if (!isRead)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981), // Green dot
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Role is not in the new API, we can hide it or use placeholder
                  /*
                  Text(
                    "Participant",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  */
                  Text(
                    lastMsg,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: isRead
                          ? FontWeight.normal
                          : FontWeight.w600,
                      color: isRead ? Colors.grey.shade600 : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
