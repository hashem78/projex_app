import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/project_provider.dart';

class PendingInvitationsTile extends ConsumerWidget {
  const PendingInvitationsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(
        Icons.email,
        color: Colors.purple,
      ),
      title: const Text('Pending invitations'),
      onTap: () {
        final projectId = ref.read(selectedProjectProvider);
        context.push('/project/$projectId/pendingInvitations');
      },
    );
  }
}
