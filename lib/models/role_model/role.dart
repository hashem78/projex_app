import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/permission/permission_model.dart';
part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class PRole with _$PRole {
  const factory PRole({
    required String id,
    required String name,
    required String color,
    @Default(0) int count,
    @Default({}) Set<PPermission> permissions,
  }) = _PRole;
  factory PRole.fromJson(Map<String, dynamic> json) => _$PRoleFromJson(json);
}
