import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_x/get.dart';
import 'package:go_roqit_app/View/Screen/Chat/controller/chat_controller.dart';
import 'package:go_roqit_app/View/Screen/Chat/model/chat_model.dart';
import 'package:go_roqit_app/View/Widgegt/HiringNavBar.dart';

class ChatDetailsView extends GetView<ChatController> {
  final ChatListModel chat;
  final TextEditingController _textController = TextEditingController();

  ChatDetailsView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const HiringNavBar(selectedIndex: 3), // Keep Nav Bar
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                      color: Colors.black,
                    ),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 16.w),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: NetworkImage(chat.imageUrl),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        chat.role,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(color: Colors.grey.shade100, height: 1),

            // Messages List
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 20.h,
                  ),
                  itemCount:
                      controller.messages.length + 1, // +1 for "Today" label
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    final message = controller.messages[index - 1];
                    return _buildMessageBubble(message);
                  },
                );
              }),
            ),

            // Input Area
            Container(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                bottom: 20.h,
                top: 10.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      if (_textController.text.isNotEmpty) {
                        controller.sendMessage(_textController.text);
                        _textController.clear();
                      }
                    },
                    child: Container(
                      width: 50.h,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B5E3F), // Theme Green
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
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

  Widget _buildMessageBubble(MessageModel message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: message.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isMe) ...[
                CircleAvatar(
                  radius: 16.r,
                  backgroundImage: NetworkImage(chat.imageUrl),
                  backgroundColor: Colors.grey.shade200,
                ),
                SizedBox(width: 8.w),
              ],

              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: message.isMe
                        ? const Color(0xFF1B5E3F)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: message.isMe
                          ? Radius.circular(16.r)
                          : Radius.zero,
                      bottomRight: message.isMe
                          ? Radius.zero
                          : Radius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: message.isMe ? Colors.white : Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          // Time Stamp
          Padding(
            padding: EdgeInsets.only(
              left: message.isMe ? 0 : 40.w,
            ), // Align under bubble if received
            child: Text(
              _formatTime(message.timestamp),
              style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade400),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    // Simple formatter for mock
    return "${timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} ${timestamp.hour >= 12 ? 'PM' : 'AM'}";
  }
}
