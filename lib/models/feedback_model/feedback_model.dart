import 'package:freezed_annotation/freezed_annotation.dart';
part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

@freezed
class PFeedBack with _$PFeedBack {
  const factory PFeedBack({
    required String id,
    required String creatorId,
    required String taskId,
    required String feedBackText,
  }) = P_FeedBack;
  factory PFeedBack.fromJson(Map<String, dynamic> json) =>
      _$PFeedBackFromJson(json);
}
