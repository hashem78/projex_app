import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/widgets/delete_something_dialog.dart';
import 'package:projex_app/state/auth.dart';

import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class RemoveMemberFromProjectButton extends ConsumerWidget {
  const RemoveMemberFromProjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authedUser = ref.watch(authProvider);
    final currentUser = ref.watch(userProvider);

    if (authedUser.id == currentUser.id) return const SizedBox();

    return IconButton(
      icon: const Icon(Icons.close, color: Colors.red),
      onPressed: () async {
        final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (_) => DeleteSomethingDialog(name: currentUser.name),
            ) ??
            false;
        if (shouldDelete) {
          await ref.read(projectProvider).removeMemberFromProject(
            memberId: [currentUser.id],
          );
        }
      },
    );
  }
}
