// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiResponseModelImpl _$$AiResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AiResponseModelImpl(
      answer: json['answer'] as String,
      page_nos: (json['page_nos'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$AiResponseModelImplToJson(
        _$AiResponseModelImpl instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'page_nos': instance.page_nos,
    };
