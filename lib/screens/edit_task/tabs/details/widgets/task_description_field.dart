import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskDescriptionTextField extends ConsumerWidget {
  const TaskDescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return TextFormField(
      initialValue: task.description,
      onChanged: (val) async {
        final task = ref.watch(taskProvider);

        final project = ref.read(projectProvider);
        await project.editTask(task.copyWith(description: val));
      },
      maxLines: 5,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Task Description',
        hintText: task.description,
      ),
    );
  }
}
