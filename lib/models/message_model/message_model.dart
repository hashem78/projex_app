import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class PMessage with _$PMessage {
  const factory PMessage({
    required String senderToken,
    required String senderId,
    required String id,
    required String text,
    required DateTime createdOn,
  }) = _PMessage;
  factory PMessage.fromJson(Map<String, dynamic> json) => _$PMessageFromJson(json);
}
