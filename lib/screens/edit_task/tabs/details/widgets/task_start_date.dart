import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskStartDateField extends ConsumerWidget {
  const TaskStartDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return FormBuilderDateTimePicker(
      name: 'dt1',
      initialValue: task.startDate!,
      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Start Date',
      ),
      onChanged: (val) async {
        final task = ref.read(taskProvider);

        final project = ref.read(projectProvider);
        await project.editTask(task.copyWith(startDate: val));
      },
    );
  }
}
