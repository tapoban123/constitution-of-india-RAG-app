import 'package:constitution_app/models/message_model.dart';

sealed class ChatDataEvents {}

final class AddNewMessageEvent extends ChatDataEvents {
  final MessageModel newMessage;

  AddNewMessageEvent({required this.newMessage});
}

final class ReceiveOldMessagesEvent extends ChatDataEvents {
  final List<MessageModel> oldMessages;

  ReceiveOldMessagesEvent({required this.oldMessages});
}

final class GenerateAiResponseEvent extends ChatDataEvents {
  final String query;

  GenerateAiResponseEvent({required this.query});
}
