import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/widgets/group_tile.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsGroupList extends ConsumerWidget {
  const ProjectSettingsGroupList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectId = ref.watch(selectedProjectProvider);
    return FirestoreQueryBuilder<ChatGroup>(
      query: FirebaseFirestore.instance
          .collection(
            'projects/$projectId/groupChats',
          )
          .withConverter(
            fromFirestore: (g, _) => ChatGroup.fromJson(g.data()!),
            toFirestore: (_, __) => {},
          ),
      builder: (context, snap, _) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: snap.docs.length,
            (context, index) {
              final group = snap.docs[index].data();
              return ProviderScope(
                overrides: [
                  selectedGroupProvider.overrideWithValue(group.id),
                ],
                child: const ProjectSettingsGroupTile(),
              );
            },
          ),
        );
      },
    );
  }
}
