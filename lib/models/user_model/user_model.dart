import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/enums/status.dart';
import 'package:projex_app/models/message_model/message_model.dart';
import 'package:projex_app/models/notification_model/notification_model.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/models/social_model/social_model.dart';
import 'package:projex_app/models/task_model/task_mode.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class PUser with _$PUser {
  const PUser._();
  Future<void> addSoicals({
    required List<PSocial> social,
  }) async {
    // TODO: user.addSocial()
  }
  Future<void> createGroup({
    required List<String> memberIds,
  }) async {
    // TODO: user.CreateGroup()
  }
  Future<void> addMembersToGroup({
    @Default("") required String groupId,
    required List<String> memberIds,
  }) async {
    // TODO: user.addMembersToGroup()
  }

  Future<void> sendProjectNotification({
    @Default("") required String projectId,
    required PNotification notification,
  }) async {
    // TODO: user.sendProjectNotification()
  }

  Future<void> sendGroupNotification({
    @Default("") required String projectId,
    @Default("") required String groupId,
    required PNotification notification,
  }) async {
    // TODO: user.sendGroupNotification()
  }

  Future<void> sendMessageInThread({
    @Default("") required String projectId,
    @Default("") required String threadId,
    required PMessage message,
  }) async {
    // TODO: user.sendMessageInThread()
  }

  Future<void> createTask({
    @Default("") required String projectId,
    required PTask task,
  }) async {
    // TODO: user.createTask()
  }

  Future<void> removeTask({
    @Default("") required String projectId,
    @Default("") required String taskId,
  }) async {
    // TODO; user.removeTask()
  }

  Future<void> setTaskStatus({
    @Default("") required String projectId,
    @Default("") required String taskId,
    required PStatus statuss,
  }) async {
    // TODO: user.setTaskStatus
  }

  Future<void> createProject({
    required PProject project,
  }) async {
    final db = FirebaseFirestore.instance;
    final batch = db.batch();
    batch.update(
      db.doc('users/$id'),
      {
        'projectIds': FieldValue.arrayUnion([project.id]),
      },
    );
    batch.set(
      db.doc('projects/${project.id}'),
      project.toJson(),
    );
    await batch.commit();
  }

  Future<void> addMembersToProject({
    required String projectId,
    required List<String> memberIds,
  }) async {
    final db = FirebaseFirestore.instance;

    await db.doc('projects/$projectId').update(
      {
        "memberIds": FieldValue.arrayUnion(
          memberIds,
        ),
      },
    );
  }

  Future<void> removeMembersFromProject({
    required String projectId,
    required List<String> memberIds,
  }) async {
    final db = FirebaseFirestore.instance;

    await db.doc('projects/$projectId').update(
      {
        "memberIds": FieldValue.arrayRemove(
          memberIds,
        ),
      },
    );
  }

  Future<void> assignRoles({
    required String projectId,
    required String userId,
    required List<PRole> rolesToAssign,
  }) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$projectId').set(
      {
        "userRoleMap": {
          userId: FieldValue.arrayUnion(rolesToAssign.map((e) => e.id).toList()),
        },
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeRoles({
    required String projectId,
    required String userId,
    required List<PRole> rolesToRemove,
  }) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$projectId').set(
      {
        "userRoleMap": {
          userId: FieldValue.arrayRemove(rolesToRemove.map((e) => e.id).toList()),
        },
      },
      SetOptions(merge: true),
    );
  }

  const factory PUser({
    @Default("") String id,
    @Default("") String name,
    @Default("") String email,
    @Default("") String phoneNumber,
    PProfilePicture? profilePicture,
    @Default([]) List<PSocial> socials,
    @Default([]) List<String> projectIds,
  }) = _PUser;

  factory PUser.fromJson(Map<String, dynamic> json) => _$PUserFromJson(json);
}
