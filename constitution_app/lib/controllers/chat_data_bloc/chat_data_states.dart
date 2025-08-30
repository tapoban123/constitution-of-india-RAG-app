import 'package:constitution_app/models/message_model.dart';

enum ChatDataStatus { initial, loading, success, error }

final class ChatDataState {
  const ChatDataState({
    this.status = ChatDataStatus.initial,
    this.messages = const [],
    this.error,
  });

  final ChatDataStatus status;
  final List<MessageModel> messages;
  final String? error;

  ChatDataState copyWith({
    ChatDataStatus? status,
    List<MessageModel>? messages,
    String? error,
  }) {
    return ChatDataState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      error: error,
    );
  }
}
