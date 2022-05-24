import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/message_model/message_model.dart';
import 'package:projex_app/models/notification_model/notification_model.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/social_model/social_model.dart';
import 'package:projex_app/models/task_model/task_mode.dart';
import 'package:projex_app/models/task_status/task_status.dart';
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
    required PTaskStatus statuss,
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

  Future<void> declineInviation(String pid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('users/$id').update(
      {
        'invitations': FieldValue.arrayRemove([pid]),
      },
    );
    await db.doc('projects/$pid').update(
      {
        'invitations': FieldValue.arrayRemove([id]),
      },
    );
  }

  Future<void> requestToJoin(String pid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('users/$id').update(
      {
        'joinRequests': FieldValue.arrayUnion([pid]),
      },
    );
    await db.doc('projects/$pid').update(
      {
        'joinRequests': FieldValue.arrayUnion([id]),
      },
    );
  }

  Future<void> cancelJoinRequest(String pid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('users/$id').update(
      {
        'joinRequests': FieldValue.arrayRemove([pid]),
      },
    );
    await db.doc('projects/$pid').update(
      {
        'joinRequests': FieldValue.arrayRemove([id]),
      },
    );
  }

  const factory PUser({
    @Default("") String id,
    @Default("") String name,
    @Default("") String email,
    @Default("") String phoneNumber,
    @Default(PProfilePicture(link: 'https://i.imgur.com/kEqAm6K.png', width: 120, height: 120))
        PProfilePicture profilePicture,
    @Default([]) List<PSocial> socials,
    @Default({}) Set<String> invitations,
    @Default({}) Set<String> joinRequests,
    @Default([]) List<String> projectIds,
  }) = _PUser;

  factory PUser.fromJson(Map<String, dynamic> json) => _$PUserFromJson(json);
}
