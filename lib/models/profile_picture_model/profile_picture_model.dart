import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_picture_model.freezed.dart';
part 'profile_picture_model.g.dart';

@freezed
class PProfilePicture with _$PProfilePicture {
  const factory PProfilePicture({
    int? width,
    int? height,
    required String link,
  }) = _PProfilePicture;
  factory PProfilePicture.fromJson(Map<String, dynamic> json) =>
      _$PProfilePictureFromJson(json);
}
