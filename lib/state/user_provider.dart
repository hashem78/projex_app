import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/user_model/user_model.dart';

class UserNotifier extends StateNotifier<PUser> {
  StreamSubscription? subscription;
  UserNotifier(String uid) : super(const PUser()) {
    if (uid.isEmpty) return;
    final db = FirebaseFirestore.instance;
    subscription = db
        .doc(
          '/users/$uid',
        )
        .withConverter<PUser>(
          fromFirestore: (snapshot, options) => PUser.fromJson(snapshot.data()!),
          toFirestore: (_, __) => {},
        )
        .snapshots()
        .listen(
      (event) {
        state = event.data()!;
      },
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

final selectedUserProvider = Provider.autoDispose<String>(
  (ref) {
    throw UnimplementedError('selected user proivder should be overriden');
  },
);

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, PUser>(
  (ref) {
    final uid = ref.watch(selectedUserProvider);
    return UserNotifier(uid);
  },
  dependencies: [selectedUserProvider],
);
