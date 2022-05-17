import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/user_model/user_model.dart';

/// The notifier for when the auth state changes
/// to be used by authProvider.
class AuthNotifier extends StateNotifier<PUser> {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  final Ref ref;

  bool isFirstTime = false;

  /// The subscription instance to the firebase auth
  /// userChanges stream, this is for cleanup.

  StreamSubscription<User?>? subscription;
  StreamSubscription<PUser?>? psubscription;

  AuthNotifier(this.ref) : super(const PUser()) {
    subscription ??= auth.userChanges().listen(
      (event) async {
        if (event != null) {
          final userDoc = await db.doc('users/${event.uid}').get();

          if (userDoc.exists) {
            state = PUser.fromJson(userDoc.data()!);
          } else {
            final puser = PUser(
              id: event.uid,
              email: event.email!,
              name: event.displayName ?? event.email!.split('@').first,
              profilePicture: PProfilePicture(
                link: event.photoURL ?? "https://i.imgur.com/qW7gjGk.jpg",
              ),
            );
            await db.doc('users/${event.uid}').set(puser.toJson());
            state = puser;
          }

          psubscription?.cancel();
          psubscription = db
              .doc(
                'users/${event.uid}',
              )
              .snapshots()
              .map(
                (event) => PUser.fromJson(event.data()!),
              )
              .listen(
            (event) {
              state = event;
            },
          );
        } else {
          state = const PUser();
        }
      },
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    psubscription?.cancel();
    super.dispose();
  }
}

/// The provider for the AuthNotifier instance responsible
/// for handeling the firebase auth userChanges stream.
/// This provider is strictly for creating an AuthNotifier instance
/// to access the currently active user use
/// pCurrentUserPorivder, or pUserProvider to access any user
/// through their uid
final authProvider = StateNotifierProvider<AuthNotifier, PUser>(
  (ref) {
    return AuthNotifier(ref);
  },
);
