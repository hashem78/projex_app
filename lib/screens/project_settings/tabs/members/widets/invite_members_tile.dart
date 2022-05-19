import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/project_provider.dart';

class InviteMembersTile extends ConsumerWidget {
  const InviteMembersTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(
        Icons.add,
        color: Colors.green,
      ),
      title: const Text('Invite members'),
      onTap: () {
        final projectId = ref.read(selectedProjectProvider);
        context.push('/project/$projectId/inviteMembers');
      },
    );
  }
}
