import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/add_members.dart';
import 'package:projex_app/state/user_provider.dart';

class MembersToBeInvitedList extends ConsumerWidget {
  const MembersToBeInvitedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(memberEmailsProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: members.length,
        (context, index) {
          final user = members.toList()[index];
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(user.id),
            ],
            child: Row(
              children: [
                const Expanded(
                  child: ProjectMemberTile(showRoles: false),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.red,
                  onPressed: () {
                    ref.read(memberEmailsProvider.notifier).remove(user);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
