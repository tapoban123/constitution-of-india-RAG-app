import 'package:constitution_app/models/message_model.dart';

enum ChatHistoryStatus { initial, loading, success, error }

class ChatHistoryState {
  final ChatHistoryStatus status;
  final List<MessageModel> msgs;
  final String? error;

  ChatHistoryState({
    this.status = ChatHistoryStatus.initial,
    this.msgs = const [],
    this.error,
  });

  ChatHistoryState copyWith({
    ChatHistoryStatus? status,
    List<MessageModel>? msgs,
    String? error,
  }) {
    return ChatHistoryState(
      status: status ?? this.status,
      msgs: msgs ?? this.msgs,
      error: error,
    );
  }
}
