import 'package:constitution_app/services/chat_history_local_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class ChatHistoryCubit extends Cubit<ChatHistoryState> {
  final ChatHistoryLocalStorageService _chatHistoryLocalStorageService;

  ChatHistoryCubit({
    required ChatHistoryLocalStorageService chatHistoryLocalStorageService,
  }) : _chatHistoryLocalStorageService = chatHistoryLocalStorageService,
       super(ChatHistoryState());

  void fetchChatHistory() async {
    emit(state.copyWith(status: ChatHistoryStatus.loading));
    try {
      final chatHistory = await _chatHistoryLocalStorageService
          .fetchChatHistory();
      emit(
        state.copyWith(status: ChatHistoryStatus.success, msgs: chatHistory),
      );
    } catch (e) {
      emit(state.copyWith(status: ChatHistoryStatus.error));
    }
  }

  void continueWithoutChatHistory() {
    emit(state.copyWith(status: ChatHistoryStatus.success, msgs: []));
  }
}
