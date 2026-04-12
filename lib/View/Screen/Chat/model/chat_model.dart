class ChatListModel {
  final String id;
  final List<Participant> participants;
  final bool status;
  final LastMessage? lastMessage;

  ChatListModel({
    required this.id,
    required this.participants,
    required this.status,
    this.lastMessage,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      id: json['_id'] ?? '',
      participants: (json['participants'] as List?)
              ?.map((p) => Participant.fromJson(p))
              .toList() ??
          [],
      status: json['status'] ?? false,
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
    );
  }
}

class Participant {
  final String id;
  final String email;
  final String name;
  final String image;

  Participant({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class LastMessage {
  final String id;
  final String chatId;
  final String sender;
  final String text;
  final DateTime createdAt;

  LastMessage({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.text,
    required this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id'] ?? '',
      chatId: json['chatId'] ?? '',
      sender: json['sender'] ?? '',
      text: json['text'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
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
