import 'package:constitution_app/controllers/chat_history_bloc/chat_history_events.dart';
import 'package:constitution_app/controllers/chat_history_bloc/chat_history_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvents, ChatHistoryState> {
  ChatHistoryBloc() : super(ChatHistoryState());

  void addMsg() {}

  void removeMsg() {}

  void fetchChatHistory() {}
}
