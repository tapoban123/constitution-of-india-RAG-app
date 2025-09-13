import 'package:hive_flutter/adapters.dart';

part 'hive_chat_history_msg_model.g.dart';

@HiveType(typeId: 0)
class HiveChatHistoryMsgModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final HiveSenderType sender;
  @HiveField(2)
  final String message;
  @HiveField(3)
  final int sentAt;
  @HiveField(4)
  final List<int>? page_nos;

  HiveChatHistoryMsgModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.sentAt,
    this.page_nos,
  });
}

@HiveType(typeId: 1)
enum HiveSenderType {
  @HiveField(0)
  USER,
  @HiveField(1)
  AI,
}
