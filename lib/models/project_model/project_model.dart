import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/models/task_model/task_model.dart';
part 'project_model.g.dart';
part 'project_model.freezed.dart';

@freezed
class PProject with _$PProject {
  const PProject._();
  Future<void> addMemberToProject({
    required String memberId,
  }) async {
    final db = FirebaseFirestore.instance;
    FirebaseFirestore.instance.doc('users/$memberId').update(
      {
        'projectIds': FieldValue.arrayUnion(
          [
            id,
          ],
        ),
      },
    );
    await db.doc('projects/$id').update(
      {
        "memberIds": FieldValue.arrayUnion(
          [memberId],
        ),
      },
    );
  }

  Future<void> removeMemberFromProject({
    required List<String> memberId,
  }) async {
    final db = FirebaseFirestore.instance;
    FirebaseFirestore.instance.doc('users/$memberId').update(
      {
        'projectIds': FieldValue.arrayRemove(
          [
            id,
          ],
        ),
      },
    );

    await db.doc('projects/$id').update(
      {
        "memberIds": FieldValue.arrayRemove(
          memberId,
        ),
      },
    );
  }

  Future<void> assignRoleToUser({
    required String userId,
    required PRole role,
  }) async {
    final db = FirebaseFirestore.instance;
    await db.doc('/projects/$id/roles/${role.id}').update(
      {'count': FieldValue.increment(1)},
    );
    await db
        .doc(
      '/projects/$id/roles/${role.id}/userIds/$userId',
    )
        .set(
      {
        'id': userId,
      },
    );

    await db.doc('projects/$id').set(
      {
        "userRoleMap": {
          userId: FieldValue.arrayUnion([role.id]),
        },
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeRoleFromUser({
    required String userId,
    required PRole role,
  }) async {
    final db = FirebaseFirestore.instance;
    await db.doc('/projects/$id/roles/${role.id}').update(
      {'count': FieldValue.increment(-1)},
    );

    await db
        .doc(
          '/projects/$id/roles/${role.id}/userIds/$userId',
        )
        .delete();
    await db.doc('projects/$id').set(
      {
        "userRoleMap": {
          userId: FieldValue.arrayRemove([role.id]),
        },
      },
      SetOptions(merge: true),
    );
  }

  Future<void> sendInvitationTo(String uid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id').update(
      {
        'invitations': FieldValue.arrayUnion([uid]),
      },
    );
    db.doc('users/$uid').update(
      {
        'invitations': FieldValue.arrayUnion([id]),
      },
    );
  }

  Future<void> removeInvitation(String uid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id').update(
      {
        'invitations': FieldValue.arrayRemove([uid]),
      },
    );
    db.doc('users/$uid').update(
      {
        'invitations': FieldValue.arrayRemove([id]),
      },
    );
  }

  Future<void> acceptJoinRequest(String uid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id').update(
      {
        'joinRequests': FieldValue.arrayRemove([uid]),
      },
    );
    db.doc('users/$uid').update(
      {
        'joinRequests': FieldValue.arrayRemove([id]),
      },
    );
    await addMemberToProject(memberId: uid);
  }

  Future<void> declineJoinRequest(String uid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id').update(
      {
        'joinRequests': FieldValue.arrayRemove([uid]),
      },
    );
    db.doc('users/$uid').update(
      {
        'joinRequests': FieldValue.arrayRemove([id]),
      },
    );
  }

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

    db.doc('projects/$id').set(
      {
        'newUserRoleMap': newUserRoleMap.map(
          (k, e) => MapEntry(
            k,
            e.toList(),
          ),
        ),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> editTask(PTask task) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/tasks/${task.id}').update(task.toJson());
  }

  Future<void> createTask(PTask task) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/tasks/${task.id}').set(task.toJson());
  }

  Future<void> removeTask(String tid) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/tasks/$tid').delete();
    final newUserTaskMap = {...userTaskMap};

    for (final v in userTaskMap.values) {
      v.remove(tid);
    }

    db.doc('projects/$id').set(
      {
        'newUserTaskMap': newUserTaskMap.map(
          (k, e) => MapEntry(
            k,
            e.toList(),
          ),
        ),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> editSubTask(String tid, PTask subTask) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/tasks/$tid/subTasks/${subTask.id}').update(subTask.toJson());
  }

  Future<void> createSubTask(String tid, PTask subTask) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/tasks/$tid/subTasks/${subTask.id}').set(subTask.toJson());
  }

  Future<void> removeSubTask(String tid, PTask subTask) async {
    final db = FirebaseFirestore.instance;
    await db.doc('projects/$id/tasks/$tid/subTasks/${subTask.id}').delete();
  }

  const factory PProject({
    required String creatorId,
    required String id,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    @Default(0) int numberOfTasks,
    @Default(0) num progress,
    @Default(true) public,
    @Default({}) Set<String> memberIds,
    @Default({}) Set<String> invitations,
    @Default({}) Set<String> joinRequests,
    @Default({}) Map<String, Set<String>> userRoleMap,
    @Default({}) Map<String, Set<String>> userTaskMap,
  }) = _PProject;

  const factory PProject.loading({
    @Default('') String creatorId,
    @Default('') String id,
    @Default('') String name,
    @Default('') String description,
    @Default(0) int numberOfTasks,
    @Default(0) num progress,
    @Default(true) public,
    @Default({}) Set<String> memberIds,
    @Default({}) Set<String> invitations,
    @Default({}) Set<String> joinRequests,
    @Default({}) Map<String, Set<String>> userRoleMap,
    @Default({}) Map<String, Set<String>> userTaskMap,
  }) = _PProjectLoading;

  factory PProject.fromJson(Map<String, dynamic> json) => _$PProjectFromJson(json);
}
