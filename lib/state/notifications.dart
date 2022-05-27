import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

StreamSubscription? deviceTokenSubscription;
Future<void> saveDeviceToken(String uid, String token) async {
  final db = FirebaseFirestore.instance;

  await db.doc('tokens/$uid').set({
    'token': token,
    'uid': uid,
  });
}

Future<void> setupTokenRefreshListener() async {
  final fm = FirebaseMessaging.instance;
  final token = await fm.getToken();
  FirebaseAuth.instance.authStateChanges().listen(
    (user) async {
      if (user != null) {
        final uid = user.uid;
        await saveDeviceToken(uid, token!);
        deviceTokenSubscription = fm.onTokenRefresh.listen(
          (token) async {
            final uid = FirebaseAuth.instance.currentUser!.uid;
            await saveDeviceToken(uid, token);
          },
        );
      }
    },
  );
}
