import 'package:freezed_annotation/freezed_annotation.dart';
part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class PRole with _$PRole {
  const factory PRole({
    required String id,
    required String name,
    required String color,
  }) = _PRole;
  factory PRole.fromJson(Map<String, dynamic> json) => _$PRoleFromJson(json);
}
