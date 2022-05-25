import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/task_status/task_status.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskStatusRadio extends ConsumerWidget {
  const TaskStatusRadio({
    Key? key,
    required this.defaultStatus,
  }) : super(key: key);

  final PTaskStatus defaultStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);
    bool canChange = true;
    defaultStatus.whenOrNull(
      complete: (_, __) {
        canChange = task.canCompleteTask;
      },
    );

    return RadioListTile<PTaskStatus>(
      activeColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      tileColor: defaultStatus.color,
      value: defaultStatus,
      groupValue: task.status,
      title: Text(
        defaultStatus.name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onChanged: canChange
          ? (val) {
              final project = ref.read(projectProvider);
              final task = ref.read(taskProvider);
              project.editTask(
                task.copyWith(status: val!),
              );
            }
          : null,
    );
  }
}
