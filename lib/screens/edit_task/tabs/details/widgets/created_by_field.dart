import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class CreatedByField extends ConsumerWidget {
  const CreatedByField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Created By',
      ),
      child: ProviderScope(
        overrides: [
          selectedUserProvider.overrideWithValue(task.creatorId),
        ],
        child: const ProjectMemberTile(
          allowAddingRoles: false,
          showRoles: false,
        ),
      ),
    );
  }
}