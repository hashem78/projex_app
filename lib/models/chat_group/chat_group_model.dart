import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_group_model.freezed.dart';
part 'chat_group_model.g.dart';

@freezed
class ChatGroup with _$ChatGroup {
  const factory ChatGroup({
    required String id,
    @Default("") String name,
    @Default(0) int memberCount,
    @Default([]) List<String> allowedRoleIds,
  }) = _ChatGroup;
  const factory ChatGroup.loading({
    required String id,
    @Default("") String name,
    @Default(0) int memberCount,
    @Default([]) List<String> allowedRoleIds,
  }) = _ChatGroupLoading;
  factory ChatGroup.fromJson(Map<String, dynamic> json) => _$ChatGroupFromJson(json);
}
