import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/widgets/delete_something_dialog.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class ProjectTaskTileActions extends ConsumerWidget {
  const ProjectTaskTileActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.projectPage;
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
          final task = ref.watch(taskProvider);
          final delete = await showDialog<bool>(
                context: context,
                builder: (_) => DeleteSomethingDialog(name: task.title),
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
          PopupMenuItem(
            value: 0,
            child: Text(translations.projectTaskMenuViewItemText),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(translations.projectTaskMenuFeedBackItemText),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              translations.projectTaskMenuDeleteItemText,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ];
      },
    );
  }
}
