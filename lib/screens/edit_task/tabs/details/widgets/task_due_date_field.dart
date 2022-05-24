import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskDueDateField extends ConsumerWidget {
  const TaskDueDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return FormBuilderDateTimePicker(
      name: 'dt3',
      initialValue: task.dueDate!,
      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Due Date',
      ),
      onChanged: (val) async {
        final project = ref.read(projectProvider);
        await project.editTask(task.copyWith(dueDate: val));
      },
    );
  }
}
