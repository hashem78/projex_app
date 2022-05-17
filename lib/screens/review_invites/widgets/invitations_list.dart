import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/review_invites/widgets/project_invitation_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class InvitationsList extends ConsumerWidget {
  const InvitationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invites = ref.watch(projectProvider).invitations;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: invites.length,
        (context, index) {
          final uid = invites.toList()[index];
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(uid),
            ],
            child: const ProjectInvitationTile(),
          );
        },
      ),
    );
  }
}
