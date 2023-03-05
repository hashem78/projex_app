import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskStartDateField extends ConsumerWidget {
  const TaskStartDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final startDate = ref.watch(taskProvider.select((value) => value.startDate));

    final container = ref.watch(translationProvider);
    final formatter = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", container.locale.name);
    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      name: 'dt1',
      initialValue: startDate,
      format: formatter,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: container.translations.taskPage.taskStartDateFieldLabelText,
      ),
      onChanged: (val) async {
        if (val != null) {
          final task = ref.read(taskProvider);

          final project = ref.read(projectProvider);
          await project.editTask(task.copyWith(startDate: val));
        }
      },
    );
  }
}
