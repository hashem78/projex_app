import 'package:freezed_annotation/freezed_annotation.dart';
part 'social_model.freezed.dart';
part 'social_model.g.dart';

@freezed
class PSocial with _$PSocial {
  const factory PSocial.facebook() = _FacebookSocial;
  const factory PSocial.twitter() = _TwitterSocial;
  const factory PSocial.instagram() = _InstagramSocial;
  const factory PSocial.snapchat() = _SnapChatSocial;

  factory PSocial.fromJson(Map<String, dynamic> json) =>
      _$PSocialFromJson(json);
}
