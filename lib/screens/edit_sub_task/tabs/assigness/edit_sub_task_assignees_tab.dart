import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class SubTaskAssigneesTab extends ConsumerWidget {
  const SubTaskAssigneesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);
    final subtask = ref.watch(subTaskProvider);
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: task.assignedToIds.length,
            (context, index) {
              final uid = task.assignedToIds[index];
              return InkWell(
                onTap: () async {
                  final project = ref.read(projectProvider);
                  final task = ref.read(taskProvider);
                  final subtask = ref.read(subTaskProvider);
                  if (!subtask.assignedToIds.contains(uid)) {
                    await project.editSubTask(
                      task.id,
                      subtask.copyWith(assignedToIds: [...subtask.assignedToIds, uid]),
                    );
                  } else {
                    final assignedCopy = [...subtask.assignedToIds];
                    assignedCopy.remove(uid);
                    await project.editSubTask(
                      task.id,
                      subtask.copyWith(assignedToIds: assignedCopy),
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
                        value: subtask.assignedToIds.contains(uid),
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
