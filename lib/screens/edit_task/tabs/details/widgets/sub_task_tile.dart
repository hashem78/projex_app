import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskTile extends ConsumerWidget {
  const SubTaskTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(subTaskProvider);
    return ListTile(
      onTap: () {
        final tid = ref.read(selectedTaskProvider);
        final subTid = ref.read(selectedSubTaskProvider);
        final pid = ref.read(selectedProjectProvider);
        context.push('/project/$pid/editTask/$tid/editSubTask/$subTid');
      },
      title: Text(task.title),
      trailing: IconButton(
        onPressed: () async {
          final project = ref.read(projectProvider);
          final tid = ref.read(selectedTaskProvider);
          final subTask = ref.read(subTaskProvider);
          await project.removeSubTask(tid, subTask);
        },
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      ),
    );
  }
}
