import 'package:constitution_app/models/ai_response_model.dart';
import 'package:constitution_app/view/widgets/message_bubble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  @JsonSerializable(explicitToJson: true)
  const factory MessageModel({
    required String id,
    required SenderType sender,
    required String message,
    required DateTime sentAt,
    List<int>? page_nos,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, Object?> json) =>
      _$MessageModelFromJson(json);

  // Map<String, Object?> toJson() => _$MessageModelToJson(this);
}
