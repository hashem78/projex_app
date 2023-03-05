import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskDescriptionTextField extends ConsumerWidget {
  const TaskDescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);

    final description = ref.watch(taskProvider.select((value) => value.description));
    final translations = ref.watch(translationProvider).translations.taskPage;

    return TextFormField(
      key: ValueKey(project),
      initialValue: description,
      onChanged: (val) async {
        final task = ref.read(taskProvider);

        final project = ref.read(projectProvider);
        await project.editTask(task.copyWith(description: val));
      },
      maxLines: 5,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: translations.taskDescriptionTextFieldLabelText,
        hintText: description,
      ),
    );
  }
}
