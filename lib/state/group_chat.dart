import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/state/project_provider.dart';

class GroupChatNotifier extends StateNotifier<ChatGroup> {
  late final StreamSubscription? subscription;
  final Ref ref;
  GroupChatNotifier(super.state, this.ref) {
    final db = FirebaseFirestore.instance;
    final pid = ref.read(selectedProjectProvider);
    subscription = db
        .doc('projects/$pid/groupChats/${state.id}')
        .snapshots()
        .map<ChatGroup>(
          (event) => ChatGroup.fromJson(event.data()!),
        )
        .listen(
      (event) {
        state = event;
      },
    );
  }
  Future<void> addRole(String rid) async {
    final db = FirebaseFirestore.instance;
    final pid = ref.read(selectedProjectProvider);
    await db.doc('projects/$pid/groupChats/${state.id}').update(
      {
        'allowedRoleIds': FieldValue.arrayUnion([rid]),
      },
    );
  }

  Future<void> removeRole(String rid) async {
    final db = FirebaseFirestore.instance;
    final pid = ref.read(selectedProjectProvider);
    await db.doc('projects/$pid/groupChats/${state.id}').update(
      {
        'allowedRoleIds': FieldValue.arrayRemove([rid]),
      },
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

final selectedGroupProvider = Provider.autoDispose<String>((ref) {
  throw UnimplementedError('Should override selectedGroupProvider');
});

final groupChatProvider = StateNotifierProvider.autoDispose<GroupChatNotifier, ChatGroup>(
  (ref) {
    final gid = ref.watch(selectedGroupProvider);
    return GroupChatNotifier(ChatGroup.loading(id: gid), ref);
  },
  dependencies: [
    selectedGroupProvider,
    selectedProjectProvider,
  ],
);
