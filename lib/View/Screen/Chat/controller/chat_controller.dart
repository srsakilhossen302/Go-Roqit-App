import 'dart:async';
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
  
  Timer? _chatListTimer;
  Timer? _messageTimer;
  String? _activeChatId;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    initChat();
    startPollingChatList();
  }

  @override
  void onClose() {
    stopPollingChatList();
    stopPollingMessages();
    scrollController.dispose();
    super.onClose();
  }

  void startPollingChatList() {
    _chatListTimer?.cancel();
    _chatListTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      loadChats(showLoading: false);
    });
  }

  void stopPollingChatList() {
    _chatListTimer?.cancel();
  }

  void startPollingMessages(String chatId) {
    _activeChatId = chatId;
    _messageTimer?.cancel();
    // Fetch immediately first
    loadMessages(chatId);
    // Then poll every 3 seconds
    _messageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_activeChatId != null) {
        loadMessages(_activeChatId!, showLoading: false);
      }
    });
  }

  void stopPollingMessages() {
    _messageTimer?.cancel();
    _activeChatId = null;
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

  Future<void> loadChats({bool showLoading = true}) async {
    if (showLoading) isLoading.value = true;
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
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> loadMessages(String chatId, {bool showLoading = true}) async {
    if (showLoading) isLoading.value = true;
    try {
      final response = await Get.find<ApiClient>().getData("${ApiUrl.getMessages}/$chatId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        if (data != null && data['messages'] != null) {
          List msgData = data['messages'];
          messages.value = msgData.map((json) => MessageModel.fromJson(json)).toList();
          
          // Scroll to bottom (only if new messages arrived or it's the first load)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            }
          });
        }
      }
    } catch (e) {
      print("Error loading messages: $e");
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    if (content.isEmpty) return;

    // Optional: Optimistic UI update
    final newMessage = MessageModel(
      id: "temp_${DateTime.now().millisecondsSinceEpoch}",
      chatId: chatId,
      sender: myId.value,
      content: content,
      type: 'TEXT',
      timestamp: DateTime.now(),
    );
    messages.add(newMessage);
    
    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    try {
      Map<String, dynamic> body = {
        "chatId": chatId,
        "text": content,
        "type": "TEXT",
      };

      final response = await Get.find<ApiClient>().postData(ApiUrl.getMessages, body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success - optionally refresh messages to get the real ID and server timestamp
        // loadMessages(chatId, showLoading: false);
      } else {
        // Revert or show error if failed
        print("Failed to send message: ${response.statusCode}");
        // messages.remove(newMessage); 
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
