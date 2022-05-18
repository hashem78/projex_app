import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class RemoveMemberFromProjectButton extends ConsumerWidget {
  const RemoveMemberFromProjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.close, color: Colors.red),
      onPressed: () async {
        final uid = ref.read(selectedUserProvider);
        await ref.read(projectProvider).removeMemberFromProject(
          memberId: [uid],
        );
      },
    );
  }
}
