import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskDueDateField extends ConsumerWidget {
  const SubTaskDueDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(subTaskProvider);

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
        final tid = ref.read(selectedTaskProvider);
        await project.editSubTask(
          tid,
          task.copyWith(dueDate: val),
        );
      },
    );
  }
}