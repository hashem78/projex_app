import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/enums/premissions.dart';
part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
class PRole with _$PRole {
  const PRole._();

  Future<void> addPermissions({
    required List<PPermission> permissions,
  }) async {
    // TODO: role.addPermissions()
  }
  const factory PRole({
    @Default([]) List<PPermission> permissions,
  }) = _PRole;
  factory PRole.fromJson(Map<String, dynamic> json) => _$PRoleFromJson(json);
}
