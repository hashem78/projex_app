import 'package:freezed_annotation/freezed_annotation.dart';
part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

@freezed
class PFeedBack with _$PFeedBack {
  const factory PFeedBack({
    @Default('') String id,
    @Default('') String creatorId,
    @Default('') String text,
  }) = P_FeedBack;
  factory PFeedBack.fromJson(Map<String, dynamic> json) => _$PFeedBackFromJson(json);
}
