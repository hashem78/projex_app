import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/pending_invitations/widgets/pending_invitation_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class PendingInvitationsList extends ConsumerWidget {
  const PendingInvitationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: project.invitations.length,
        (context, index) {
          final uid = project.invitations.toList()[index];
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(uid),
            ],
            child: const ProjectPendingInvitationTile(),
          );
        },
      ),
    );
  }
}
