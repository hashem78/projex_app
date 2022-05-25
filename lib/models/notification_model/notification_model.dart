import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/role_model/role.dart';
part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class PNotification with _$PNotification {
  const factory PNotification({
    required String id,
    required List<PRole> roles,
  }) = _PNotification;
  factory PNotification.fromJson(Map<String, dynamic> json) => _$PNotificationFromJson(json);
}
