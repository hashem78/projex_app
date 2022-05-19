import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/remove_member_from_project_button.dart';
import 'package:projex_app/state/editing.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class MembersTab extends ConsumerWidget {
  const MembersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProvider(EditReason.project));
    final project = ref.watch(projectProvider);
    return CustomScrollView(
      slivers: [
        if (project.invitations.isNotEmpty)
          SliverToBoxAdapter(
            child: ListTile(
              leading: const Icon(
                Icons.email_outlined,
                color: Colors.blue,
              ),
              title: const Text('View pending invitations'),
              onTap: () {
                context.push('/project/${project.id}/pendingInvitations');
              },
            ),
          ),
        if (isEditing)
          SliverToBoxAdapter(
            child: ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.blue,
              ),
              title: const Text('Invite members'),
              onTap: () {
                context.push('/project/${project.id}/inviteMembers');
              },
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: project.memberIds.length,
            (context, index) {
              final uid = project.memberIds.toList()[index];
              var isOwner = project.userRoleMap[uid]?.contains('owner') ?? false;

              if (isEditing) {
                return ProviderScope(
                  overrides: [
                    selectedUserProvider.overrideWithValue(uid),
                  ],
                  child: Row(
                    children: [
                      Expanded(
                        child: Consumer(builder: (context, ref, _) {
                          return ProjectMemberTile(
                            onTap: () {
                              final user = ref.read(userProvider);
                              context.push('/profile/${user.id}');
                            },
                          );
                        }),
                      ),
                      if (!isOwner) const RemoveMemberFromProjectButton(),
                    ],
                  ),
                );
              } else {
                return ProviderScope(
                  overrides: [
                    selectedUserProvider.overrideWithValue(uid),
                  ],
                  child: Consumer(builder: (context, ref, _) {
                    return ProjectMemberTile(
                      onTap: () {
                        final project = ref.read(projectProvider);
                        context.push('/project/${project.id}/chatWith/$uid');
                      },
                    );
                  }),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
