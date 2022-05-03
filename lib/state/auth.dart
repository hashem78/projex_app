import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/user_model/user_model.dart';

/// The notifier for when the auth state changes
/// to be used by authProvider.
class AuthNotifier extends ChangeNotifier {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  bool isFirstTime = false;

  /// The subscription instance to the firebase auth
  /// userChanges stream, this is for cleanup.

  StreamSubscription<User?>? subscription;

  User? user;

  bool get isLoggedIn => user != null;
  bool get isNotLoggedIn => user == null;

  AuthNotifier() {
    subscription ??= auth.userChanges().listen(
      (event) async {
        user = event;
        if (user != null) {
          final userDoc = await db.doc('users/${user!.uid}').get();
          isFirstTime = !userDoc.exists;
        }
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

/// The provider for the AuthNotifier instance responsible
/// for handeling the firebase auth userChanges stream.
/// This provider is strictly for creating an AuthNotifier instance
/// to access the currently active user use
/// pCurrentUserPorivder, or pUserProvider to access any user
/// through their uid
final authProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) {
    return AuthNotifier();
  },
);

/// Provides a stream that changes whenever the database
/// entry for the currently loggedin user changes.
final pCurrentUserProvider = StreamProvider<PUser?>(
  (ref) async* {
    final auth = ref.read(authProvider);
    final user = auth.user!;
    final db = FirebaseFirestore.instance;
    yield* db.doc('users/${user.uid}').snapshots().map(
      (event) {
        final data = event.data();
        if (data != null) {
          return PUser.fromJson(data);
        }
        return null;
      },
    );
  },
);

/// Provides a stream that changes whenever the database
/// entry for a user changes.
final pUserProvider = StreamProvider.family<PUser?, String>(
  (ref, uid) async* {
    final db = FirebaseFirestore.instance;
    yield* db.doc('users/$uid').snapshots().map(
      (event) {
        final data = event.data();
        if (data != null) {
          return PUser.fromJson(data);
        }
        return null;
      },
    );
  },
);
