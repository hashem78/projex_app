import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/screens/project_settings/tabs/members/manage_members_tab.dart';
import 'package:projex_app/screens/project_settings/tabs/roles/roles_tab.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:uuid/uuid.dart';

class ProjectSettingsScreen extends ConsumerWidget {
  const ProjectSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                title: Text('${project.name} Settings'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Members'),
                    Tab(text: 'Roles'),
                    Tab(text: 'Groups'),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ManageMembersTab(),
              RolesTab(),
              ManageGroupsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class ManageGroupsTab extends ConsumerStatefulWidget {
  const ManageGroupsTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ManageGroupsTab> createState() => _ManageGroupsTabState();
}

class _ManageGroupsTabState extends ConsumerState<ManageGroupsTab> {
  @override
  Widget build(BuildContext context) {
    final projectId = ref.watch(selectedProjectProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create Group'),
            onTap: () async {
              final projectId = ref.read(selectedProjectProvider);
              final uuid = const Uuid().v4();
              final group = ChatGroup(id: uuid, name: 'New Group Chat');
              await FirebaseFirestore.instance
                  .doc(
                'projects/$projectId/groupChats/$uuid',
              )
                  .set(
                {
                  ...group.toJson(),
                  'tokens': <String>[],
                },
              );
              if (!mounted) return;
              context.push('/project/$projectId/editChatGroup/$uuid');
            },
          ),
        ),
        FirestoreQueryBuilder<ChatGroup>(
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
                  return ListTile(
                    onTap: () {
                      context.push('/project/$projectId/editChatGroup/${group.id}');
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(group.memberCount.toString()),
                        const Icon(Icons.person),
                      ],
                    ),
                    title: Text(group.name),
                    trailing: IconButton(
                      onPressed: () async {
                        final projectId = ref.read(selectedProjectProvider);
                        final db = FirebaseFirestore.instance;
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Group Chat'),
                              content: Text('Are you sure you want to delete ${group.name}?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                        if (shouldDelete != null) {
                          if (shouldDelete) {
                            await db.doc('projects/$projectId/groupChats/${group.id}').delete();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
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
