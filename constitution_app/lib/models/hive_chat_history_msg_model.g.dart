// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_chat_history_msg_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveChatHistoryMsgModelAdapter
    extends TypeAdapter<HiveChatHistoryMsgModel> {
  @override
  final int typeId = 0;

  @override
  HiveChatHistoryMsgModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveChatHistoryMsgModel(
      id: fields[0] as String,
      sender: fields[1] as HiveSenderType,
      message: fields[2] as String,
      sentAt: fields[3] as int,
      page_nos: (fields[4] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveChatHistoryMsgModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.sentAt)
      ..writeByte(4)
      ..write(obj.page_nos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveChatHistoryMsgModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveSenderTypeAdapter extends TypeAdapter<HiveSenderType> {
  @override
  final int typeId = 1;

  @override
  HiveSenderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HiveSenderType.USER;
      case 1:
        return HiveSenderType.AI;
      default:
        return HiveSenderType.USER;
    }
  }

  @override
  void write(BinaryWriter writer, HiveSenderType obj) {
    switch (obj) {
      case HiveSenderType.USER:
        writer.writeByte(0);
        break;
      case HiveSenderType.AI:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveSenderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
