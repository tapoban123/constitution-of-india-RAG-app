import 'dart:developer';

import 'package:constitution_app/controllers/chat_data_bloc/chat_data_events.dart';
import 'package:constitution_app/controllers/chat_data_bloc/chat_data_states.dart';
import 'package:constitution_app/models/message_model.dart';
import 'package:constitution_app/services/ai_generation_service.dart';
import 'package:constitution_app/services/chat_history_local_storage_service.dart';
import 'package:constitution_app/view/widgets/message_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatDataBloc extends Bloc<ChatDataEvents, ChatDataState> {
  final AiGenerationService _aiGenerationService;
  final ChatHistoryLocalStorageService _chatHistoryLocalStorageService;

  ChatDataBloc({
    required AiGenerationService aiGenerationService,
    required ChatHistoryLocalStorageService chatHistoryLocalStorageService,
  }) : _aiGenerationService = aiGenerationService,
       _chatHistoryLocalStorageService = chatHistoryLocalStorageService,
       super(ChatDataState()) {
    on<AddNewMessageEvent>(addNewMessage);
    on<ReceiveOldMessagesEvent>(fetchOldMessages);
    on<GenerateAiResponseEvent>(generateAiResponse);
    on<DeleteChatHistoryEvent>(deleteChatHistory);
  }

  void addNewMessage(AddNewMessageEvent event, Emitter emit) {
    _chatHistoryLocalStorageService.addMsg(event.newMessage);
    emit(state.copyWith(messages: [...state.messages, event.newMessage]));
  }

  void fetchOldMessages(ReceiveOldMessagesEvent event, Emitter emit) {
    event.oldMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));

    emit(state.copyWith(messages: event.oldMessages));
  }

  void generateAiResponse(GenerateAiResponseEvent event, Emitter emit) async {
    emit(state.copyWith(status: ChatDataStatus.loading));
    final aiResponse = await _aiGenerationService.getAiResponse(
      query: event.query,
    );

    if (aiResponse != null) {
      final newMessage = MessageModel(
        id: Uuid().v4(),
        message: aiResponse.answer,
        sentAt: DateTime.now(),
        sender: SenderType.AI,
        page_nos: aiResponse.page_nos,
      );

      await _chatHistoryLocalStorageService.addMsg(newMessage);

      emit(
        state.copyWith(
          status: ChatDataStatus.success,
          messages: [...state.messages, newMessage],
        ),
      );
    }
    emit(
      state.copyWith(
        status: ChatDataStatus.error,
        error: "AI Generation Failed.",
      ),
    );
  }

  void deleteChatHistory(DeleteChatHistoryEvent event, Emitter emit) async {
    emit(state.copyWith(status: ChatDataStatus.loading));
    await _chatHistoryLocalStorageService.deleteChatHistory();
    emit(state.copyWith(status: ChatDataStatus.success, messages: []));
  }
}
