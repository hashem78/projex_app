import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/screens/project_settings/tabs/members/widets/invite_members_tile.dart';
import 'package:projex_app/screens/project_settings/tabs/members/widets/pending_invitations_tille.dart';
import 'package:projex_app/screens/project_settings/tabs/members/widets/review_join_requests_tile.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class ManageMembersTab extends ConsumerWidget {
  const ManageMembersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final translations = ref.watch(translationProvider).translations.projectSettings;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            const [
              InviteMembersTile(),
              PendingInvitationsTile(),
              ReviewJoinRequestsTile(),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverToBoxAdapter(
            child: Text(translations.membersTabProjectMembersTitleText),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: project.memberIds.length,
            (context, index) {
              final uid = project.memberIds.toList()[index];
              return ProviderScope(
                overrides: [
                  selectedUserProvider.overrideWithValue(uid),
                ],
                child: ProjectMemberTile(
                  allowAddingRoles: true,
                  showRoles: true,
                  onTap: () => context.push('/profile/$uid'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
