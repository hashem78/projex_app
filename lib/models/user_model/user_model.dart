import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/social_model/social_model.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class PUser with _$PUser {
  const PUser._();

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
