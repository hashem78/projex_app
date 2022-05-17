import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class RemoveMemberFromProjectButton extends ConsumerWidget {
  const RemoveMemberFromProjectButton({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return IconButton(
      icon: const Icon(Icons.close, color: Colors.red),
      onPressed: () async {
        await ref.read(authProvider).removeMembersFromProject(
          projectId: project.id,
          memberIds: [uid],
        );
      },
    );
  }
}
