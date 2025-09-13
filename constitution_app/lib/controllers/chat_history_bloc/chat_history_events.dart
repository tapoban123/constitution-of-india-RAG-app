sealed class ChatHistoryEvents {}

class AddMsgToHistoryEvent extends ChatHistoryEvents {}

class RemoveMsgFromHistoryEvent extends ChatHistoryEvents {}

class FetchChatHistoryEvent extends ChatHistoryEvents {}

class DeleteEntireHistoryEvent extends ChatHistoryEvents {}
