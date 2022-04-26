import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The notifier for when the auth state changes
// to be used by authProvider

class AuthNotifier extends ChangeNotifier {
  // The subscription instance to the firebase auth
  // userChanges stream, this is for cleanup.

  // TODO: transform the default firebase User to PUser
  StreamSubscription<User?>? subscription;

  // The data of the current User
  // TODO: When the transformation to PUser is done this is going to be an instance of PUser?
  User? user;

  bool get isLoggedIn => user != null;
  bool get isNotLoggedIn => user == null;

  AuthNotifier() : user = null {
    subscription ??= FirebaseAuth.instance.userChanges().listen(
      (event) {
        user = event;
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

// The provider for the AuthNotifier instance responsible
// for handeling the firebase auth userChanges stream.
final authProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) {
    return AuthNotifier();
  },
);
