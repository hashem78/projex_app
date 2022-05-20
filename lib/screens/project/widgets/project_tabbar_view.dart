import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';

import 'package:projex_app/screens/project/widgets/tabs/members/members_tab.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/tasks_tab.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectTabBarView extends StatelessWidget {
  const ProjectTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        TasksTab(),
        MembersTab(),
        GroupsTab(),
      ],
    );
  }
}

class GroupsTab extends ConsumerWidget {
  const GroupsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectId = ref.watch(selectedProjectProvider);
    final project = ref.watch(projectProvider);
    final authedUser = ref.watch(authProvider);

    return CustomScrollView(
      slivers: [
        FirestoreQueryBuilder<ChatGroup>(
          query: FirebaseFirestore.instance
              .collection(
                'projects',
              )
              .doc(projectId)
              .collection('groupChats')
              .where(
                'allowedRoleIds',
                arrayContains: project.userRoleMap[authedUser]?.toList(),
              )
              .withConverter<ChatGroup>(
                fromFirestore: (g, _) => ChatGroup.fromJson(g.data()!),
                toFirestore: (_, __) => {},
              ),
          builder: (context, snap, _) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: snap.docs.length,
                (context, index) {
                  final group = snap.docs[index].data();
                  return ListTile(
                    onTap: () {
                      final projectId = ref.read(selectedProjectProvider);

                      context.push('/project/$projectId/groupChat/${group.id}');
                    },
                    title: Text(group.name),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
