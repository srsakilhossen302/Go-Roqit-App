class ChatListModel {
  final String id;
  final String name;
  final String role;
  final String imageUrl;
  final String lastMessage;
  final String time;
  final bool isRead;

  ChatListModel({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.lastMessage,
    required this.time,
    required this.isRead,
  });
}

class MessageModel {
  final String id;
  final String content;
  final bool isMe;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.content,
    required this.isMe,
    required this.timestamp,
  });
}
