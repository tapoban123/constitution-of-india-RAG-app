import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_response_model.g.dart';

part 'ai_response_model.freezed.dart';

@freezed
abstract class AiResponseModel with _$AiResponseModel {
  @JsonSerializable(explicitToJson: true)
  const factory AiResponseModel({
    required String answer,
    required List<int> page_nos,
  }) = _AiResponseModel;

  factory AiResponseModel.fromJson(Map<String, Object?> json) =>
      _$AiResponseModelFromJson(json);
}
