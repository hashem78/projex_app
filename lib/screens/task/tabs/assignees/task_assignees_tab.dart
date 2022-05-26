import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class TaskAssigneesTab extends ConsumerWidget {
  const TaskAssigneesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final task = ref.watch(taskProvider);
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: project.memberIds.length,
            (context, index) {
              final uid = project.memberIds.toList()[index];
              return InkWell(
                onTap: () async {
                  final project = ref.read(projectProvider);
                  final task = ref.read(taskProvider);
                  if (!task.assignedToIds.contains(uid)) {
                    await project.editTask(
                      task.copyWith(assignedToIds: [...task.assignedToIds, uid]),
                    );
                  } else {
                    final assignedCopy = [...task.assignedToIds];
                    assignedCopy.remove(uid);
                    await project.editTask(
                      task.copyWith(assignedToIds: assignedCopy),
                    );
                  }
                },
                child: Row(
                  children: [
                    ProviderScope(
                      overrides: [
                        selectedUserProvider.overrideWithValue(uid),
                      ],
                      child: const ProjectMemberTile(
                        allowAddingRoles: false,
                        showRoles: true,
                      ),
                    ),
                    const Spacer(),
                    IgnorePointer(
                      ignoring: true,
                      child: Checkbox(
                        value: task.assignedToIds.contains(uid),
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
