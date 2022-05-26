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
    final project = ref.watch(projectProvider);
    final dueDate = ref.watch(taskProvider.select((value) => value.dueDate));

    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      name: 'dt3',
      initialValue: dueDate,
      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Due Date',
      ),
      onChanged: (val) async {
        if (val != null) {
          final project = ref.read(projectProvider);
          final task = ref.read(taskProvider);
          await project.editTask(task.copyWith(dueDate: val));
        }
      },
    );
  }
}
