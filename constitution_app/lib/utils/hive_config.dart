import 'package:constitution_app/models/hive_chat_history_msg_model.dart';
import 'package:hive_flutter/adapters.dart';

const String CHAT_HISTORY_BOX = "chat_history";

class HiveConfig {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<HiveChatHistoryMsgModel>(
      HiveChatHistoryMsgModelAdapter(),
    );
    Hive.registerAdapter<HiveSenderType>(HiveSenderTypeAdapter());
    await Hive.openBox<HiveChatHistoryMsgModel>(CHAT_HISTORY_BOX);
  }
}
