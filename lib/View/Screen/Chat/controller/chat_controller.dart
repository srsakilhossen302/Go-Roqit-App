import 'package:get_x/get.dart';
import '../model/chat_model.dart';

import 'package:flutter/widgets.dart'; // For ScrollController

class ChatController extends GetxController {
  var chatList = <ChatListModel>[].obs;
  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  Future<void> refreshChats() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    loadChats();
    isLoading.value = false;
  }

  void loadChats() {
    // Mock data based on the provided image
    chatList.value = [
      ChatListModel(
        id: '1',
        name: 'Glow Beauty Salon',
        role: 'Senior Hair Stylist',
        imageUrl: 'https://i.pravatar.cc/150?u=glow',
        lastMessage: 'Great! When can you come in for a trial shift?',
        time: '30m ago',
        isRead: false,
      ),
      ChatListModel(
        id: '2',
        name: 'Sarah Mitchell',
        role: 'Hair Stylist',
        imageUrl: 'https://i.pravatar.cc/150?u=sarah',
        lastMessage: 'Thanks for your application! We\'d love to chat.',
        time: '2h ago',
        isRead: true,
      ),
      ChatListModel(
        id: '3',
        name: 'The Grooming Room',
        role: 'Barber',
        imageUrl: 'https://i.pravatar.cc/150?u=grooming',
        lastMessage: 'The position is still available if you\'re interested.',
        time: '1d ago',
        isRead: true,
      ),
    ];
  }

  void loadMessages(String chatId) {
    // Determine the partner name based on selected chat (simplified for mock)
    // In a real app, this would fetch from API based on chatId

    // Mock messages for 'Glow Beauty Salon' (Chat Details UI match)
    messages.value = [
      MessageModel(
        id: '1',
        content:
            'Hi! I saw your application for the stylist position. Your portfolio looks amazing!',
        isMe: false, // Received
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      MessageModel(
        id: '2',
        content: 'Thank you so much! I\'d love to learn more about the role.',
        isMe: true, // Sent
        timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
      ),
      MessageModel(
        id: '3',
        content: 'Great! When can you come in for a trial shift?',
        isMe: false, // Received
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      ),
    ];

    // Scroll to bottom when messages are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void sendMessage(String content) {
    if (content.isEmpty) return;

    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        content: content,
        isMe: true,
        timestamp: DateTime.now(),
      ),
    );

    // Scroll to bottom after sending
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
