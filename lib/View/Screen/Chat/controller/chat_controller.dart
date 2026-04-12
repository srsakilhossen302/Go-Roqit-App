import 'package:get_x/get.dart';
import 'package:go_roqit_app/service/api_client.dart';
import 'package:go_roqit_app/service/api_url.dart';
import '../model/chat_model.dart';
import 'package:flutter/widgets.dart';

class ChatController extends GetxController {
  var chatList = <ChatListModel>[].obs;
  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;
  var myId = "".obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    initChat();
  }

  Future<void> initChat() async {
    await fetchMyProfile();
    await loadChats();
  }

  Future<void> fetchMyProfile() async {
    try {
      final response = await Get.find<ApiClient>().getData(ApiUrl.getProfile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null) {
          myId.value = data['_id'] ?? "";
        }
      }
    } catch (e) {
      print("Error fetching profile in ChatController: $e");
    }
  }

  Future<void> refreshChats() async {
    await loadChats();
  }

  Future<void> loadChats() async {
    isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().getData(ApiUrl.createChat);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null && data is List) {
          chatList.value = data.map((json) => ChatListModel.fromJson(json)).toList();
        }
      }
    } catch (e) {
      print("Error loading chats: $e");
    } finally {
      isLoading.value = false;
    }
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
