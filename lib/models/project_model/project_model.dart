import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/role_model/role.dart';
part 'project_model.g.dart';
part 'project_model.freezed.dart';

@freezed
class PProject with _$PProject {
  const factory PProject({
    required String id,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    @Default({}) Set<String> memberIds,
    @Default({}) Set<PRole> roles,
    @Default({}) Map<String, Set<String>> userRoleMap,
  }) = _PProject;
  factory PProject.fromJson(Map<String, dynamic> json) => _$PProjectFromJson(json);
}
