import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/role_model/role.dart';
part 'project_model.g.dart';
part 'project_model.freezed.dart';

@freezed
class PProject with _$PProject {
  const PProject._();
  Future<void> editRole(PRole role) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/roles/${role.id}').update(role.toJson());
  }

  Future<void> createRole(PRole role) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/roles/${role.id}').set(role.toJson());
  }

  Future<void> removeRole(String rid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/roles/$rid').delete();
    final newUserRoleMap = {...userRoleMap};
    for (final v in userRoleMap.values) {
      v.remove(rid);
    }
    db.doc('projects/$id').set(newUserRoleMap);
  }

  const factory PProject({
    required String creatorId,
    required String id,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    @Default(true) public,
    @Default({}) Set<String> memberIds,
    @Default({}) Map<String, Set<String>> userRoleMap,
  }) = _PProject;

  const factory PProject.loading({
    @Default('') String creatorId,
    @Default('') String id,
    @Default('') String name,
    @Default('') String description,
    @Default(true) public,
    @Default({}) Set<String> memberIds,
    @Default({}) Map<String, Set<String>> userRoleMap,
  }) = _PProjectLoading;

  factory PProject.fromJson(Map<String, dynamic> json) => _$PProjectFromJson(json);
}
