// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String,
      sender: $enumDecode(_$SenderTypeEnumMap, json['sender']),
      message: json['message'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      page_nos: (json['page_nos'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': _$SenderTypeEnumMap[instance.sender]!,
      'message': instance.message,
      'sentAt': instance.sentAt.toIso8601String(),
      'page_nos': instance.page_nos,
    };

const _$SenderTypeEnumMap = {
  SenderType.USER: 'USER',
  SenderType.AI: 'AI',
};
