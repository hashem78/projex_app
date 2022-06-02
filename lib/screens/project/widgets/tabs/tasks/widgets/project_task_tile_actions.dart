import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/delete_task_dialog.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class ProjectTaskTileActions extends ConsumerWidget {
  const ProjectTaskTileActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      onSelected: (val) async {
        if (val == 0) {
          final pid = ref.read(selectedProjectProvider);
          final tid = ref.read(selectedTaskProvider);
          context.push('/project/$pid/task/$tid');
        } else if (val == 1) {
          final pid = ref.read(selectedProjectProvider);
          final tid = ref.read(selectedTaskProvider);
          context.push('/project/$pid/task/$tid/feedback');
        } else if (val == 2) {
          final delete = await showDialog<bool>(
                context: context,
                builder: (_) => const DeleteTaskDialog(),
              ) ??
              false;
          if (delete) {
            final project = ref.read(projectProvider);
            final tid = ref.read(selectedTaskProvider);
            await project.removeTask(tid);
          }
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 0,
            child: Text('View'),
          ),
          const PopupMenuItem(
            value: 1,
            child: Text(
              'Feedback',
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ];
      },
    );
  }
}
