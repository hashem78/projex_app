import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/state/project_provider.dart';

StreamSubscription? deviceTokenSubscription;
void setupDeviceTokenStream(String pid, List<ChatGroup> groups) {
  final fm = FirebaseMessaging.instance;
  deviceTokenSubscription?.cancel();
  deviceTokenSubscription = fm.onTokenRefresh.listen(
    (token) async {
      for (final group in groups) {
        await group.saveDeviceToken(pid, token);
      }
    },
  );
}

final availableGroupsProvider = FutureProvider.autoDispose<List<ChatGroup>>(
  (ref) async {
    final fc = FirebaseFunctions.instance;
    final fm = FirebaseMessaging.instance;
    final pid = ref.watch(selectedProjectProvider);

    final res = await fc.httpsCallable('getAllowedGroupsForUser').call(
      <String, dynamic>{
        'projectId': pid,
      },
    );
    final jsonGroups = res.data as List;
    final groups = <ChatGroup>[];
    for (final jsonGroup in jsonGroups) {
      groups.add(ChatGroup.fromJson(Map<String, dynamic>.from(jsonGroup)));
    }
    final token = await fm.getToken();
    for (final group in groups) {
      await group.saveDeviceToken(pid, token!);
    }
    setupDeviceTokenStream(pid, groups);

    ref.onDispose(
      () {
        deviceTokenSubscription?.cancel();
      },
    );
    return groups;
  },
  dependencies: [selectedProjectProvider],
);
