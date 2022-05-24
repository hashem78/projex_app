import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskDescriptionTextField extends ConsumerWidget {
  const SubTaskDescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(subTaskProvider);

    return TextFormField(
      initialValue: task.description,
      onChanged: (val) async {
        final task = ref.watch(subTaskProvider);

        final project = ref.read(projectProvider);
        final tid = ref.read(selectedTaskProvider);
        await project.editSubTask(
          tid,
          task.copyWith(description: val),
        );
      },
      maxLines: 5,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'SubTask Description',
        hintText: task.title,
      ),
    );
  }
}
