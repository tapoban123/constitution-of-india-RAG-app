import 'package:constitution_app/models/hive_chat_history_msg_model.dart';
import 'package:constitution_app/models/message_model.dart';
import 'package:constitution_app/utils/hive_config.dart';
import 'package:constitution_app/view/widgets/message_bubble.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatHistoryLocalStorageService {
  Box _chatHistoryBox = Hive.box<HiveChatHistoryMsgModel>(CHAT_HISTORY_BOX);

  Future<void> addMsg(MessageModel message) async {
    if (!_chatHistoryBox.isOpen) {
      _chatHistoryBox = await Hive.openBox(CHAT_HISTORY_BOX);
    }
    final msg = HiveChatHistoryMsgModel(
      id: message.id,
      sender: message.sender == SenderType.USER
          ? HiveSenderType.USER
          : HiveSenderType.AI,
      message: message.message,
      sentAt: message.sentAt.millisecondsSinceEpoch,
      page_nos: message.page_nos,
    );
    await _chatHistoryBox.put(message.id, msg);
  }

  void removeMsg(String msgId) {}

  Future<List<MessageModel>> fetchChatHistory() async {
    final chatHistory = _chatHistoryBox.values
        .map(
          (e) => MessageModel(
            id: e.id,
            sender: e.sender == HiveSenderType.USER
                ? SenderType.USER
                : SenderType.AI,
            message: e.message,
            sentAt: DateTime.fromMillisecondsSinceEpoch(e.sentAt),
          ),
        )
        .toList();

    return chatHistory;
  }

  Future<void> deleteChatHistory() async {
    await _chatHistoryBox.deleteFromDisk();
  }
}
