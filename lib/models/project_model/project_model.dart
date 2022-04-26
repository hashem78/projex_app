import 'package:freezed_annotation/freezed_annotation.dart';
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
    required String tasksCollectionId,
    required String rolesCollectionId,
    required String usersCollectionId,
    required String threadsCollectionId,
    required String subGroupsCollectionId,
  }) = _PProject;
  factory PProject.fromJson(Map<String, dynamic> json) =>
      _$PProjectFromJson(json);
}
