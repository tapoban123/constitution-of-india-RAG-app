import 'dart:developer';

import 'package:constitution_app/controllers/chat_data_bloc/chat_data_events.dart';
import 'package:constitution_app/controllers/chat_data_bloc/chat_data_states.dart';
import 'package:constitution_app/models/message_model.dart';
import 'package:constitution_app/services/ai_generation_service.dart';
import 'package:constitution_app/view/widgets/message_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatDataBloc extends Bloc<ChatDataEvents, ChatDataState> {
  final AiGenerationService _aiGenerationService;

  ChatDataBloc({required AiGenerationService aiGenerationService})
    : _aiGenerationService = aiGenerationService,
      super(ChatDataState()) {
    on<AddNewMessageEvent>(addNewMessage);
    on<ReceiveOldMessagesEvent>(receiveOldMessages);
    on<GenerateAiResponseEvent>(generateAiResponse);
  }

  void addNewMessage(AddNewMessageEvent event, Emitter emit) {
    emit(state.copyWith(messages: [...state.messages, event.newMessage]));
  }

  void receiveOldMessages(ReceiveOldMessagesEvent event, Emitter emit) {

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

      log(newMessage.toString());

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
}
