import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/task_status/task_status.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskStatusRadio extends ConsumerWidget {
  const SubTaskStatusRadio({
    Key? key,
    required this.defaultStatus,
  }) : super(key: key);

  final PTaskStatus defaultStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(subTaskProvider);
    final translations = ref.watch(translationProvider).translations;

    return RadioListTile<PTaskStatus>(
      activeColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      tileColor: defaultStatus.color,
      value: defaultStatus,
      groupValue: task.status,
      title: Text(
        translations[defaultStatus.name],
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onChanged: (val) {
        final project = ref.read(projectProvider);
        final tid = ref.read(selectedTaskProvider);
        final task = ref.read(subTaskProvider);
        project.editSubTask(
          tid,
          task.copyWith(status: val!),
        );
      },
    );
  }
}
