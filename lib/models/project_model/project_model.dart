import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/role_model/role.dart';
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
    @Default({}) Set<String> invitations,
    @Default({}) Set<String> joinRequests,
    @Default({}) Map<String, Set<String>> userRoleMap,
  }) = _PProject;

  const factory PProject.loading({
    @Default('') String creatorId,
    @Default('') String id,
    @Default('') String name,
    @Default('') String description,
    @Default(true) public,
    @Default({}) Set<String> memberIds,
    @Default({}) Set<String> invitations,
    @Default({}) Set<String> joinRequests,
    @Default({}) Map<String, Set<String>> userRoleMap,
  }) = _PProjectLoading;

  factory PProject.fromJson(Map<String, dynamic> json) => _$PProjectFromJson(json);
}
