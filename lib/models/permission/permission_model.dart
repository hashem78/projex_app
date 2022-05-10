import 'package:freezed_annotation/freezed_annotation.dart';
part 'permission_model.freezed.dart';
part 'permission_model.g.dart';

@freezed
class PPermission with _$PPermission {
  const factory PPermission.admin({
    @Default('admin') String fieldName,
    @Default('Admin') String title,
  }) = _PPermissionAdmin;
  const factory PPermission.edit({
    @Default('edit') String fieldName,
    @Default('Edit') String title,
  }) = _PPermissionEdit;
  const factory PPermission.changeNickName({
    @Default('cnn') String fieldName,
    @Default('Change nick name') String title,
  }) = _PPermissionChangeNickName;
  const factory PPermission.changeNickNames({
    @Default('cnns') String fieldName,
    @Default('Change nick names') String title,
  }) = _PPermissionChangeNickNames;
  const factory PPermission.kickMembers({
    @Default('km') String fieldName,
    @Default('Kick members') String title,
  }) = _PPermissionKickMembers;
  const factory PPermission.banMembers({
    @Default('bm') String fieldName,
    @Default('Ban members') String title,
  }) = _PPermissionBanMembers;
  const factory PPermission.sendMessage({
    @Default('sm') String fieldName,
    @Default('Send message') String title,
  }) = _PPermissionSendMessage;
  const factory PPermission.sendMessageInThread({
    @Default('smit') String fieldName,
    @Default('Send message in threads') String title,
  }) = _PPermissionMessageInThread;
  const factory PPermission.createThread({
    @Default('ct') String fieldName,
    @Default('Create threads') String title,
  }) = _PPermissionCreateThread;
  const factory PPermission.attachFiles({
    @Default('af') String fieldName,
    @Default('Attach Files') String title,
  }) = _PPermissionAttachFiles;
  const factory PPermission.addReactions({
    @Default('ar') String fieldName,
    @Default('Add reactions') String title,
  }) = _PPermissionAddReactions;
  const factory PPermission.mentionAll({
    @Default('ma') String fieldName,
    @Default('Mention all') String title,
  }) = _PPermissionMentionAll;
  const factory PPermission.readHistory({
    @Default('rh') String fieldName,
    @Default('Read History') String title,
  }) = _PPermissionReadHistory;
  static const List<PPermission> values = [
    PPermission.admin(),
    PPermission.edit(),
    PPermission.changeNickName(),
    PPermission.changeNickNames(),
    PPermission.kickMembers(),
    PPermission.banMembers(),
    PPermission.sendMessage(),
    PPermission.sendMessageInThread(),
    PPermission.createThread(),
    PPermission.attachFiles(),
    PPermission.addReactions(),
    PPermission.mentionAll(),
    PPermission.readHistory(),
  ];
  factory PPermission.fromJson(Map<String, dynamic> json) => _$PPermissionFromJson(json);
}
