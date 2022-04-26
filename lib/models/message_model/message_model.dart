import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/enums/importance.dart';
part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class PMessage with _$PMessage {
  const factory PMessage({
    required String senderId,
    required String messageId,
    required String messageText,
    Importance? importance,
  }) = _PMessage;
  factory PMessage.fromJson(Map<String, dynamic> json) =>
      _$PMessageFromJson(json);
}
