import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskEndDateField extends ConsumerWidget {
  const TaskEndDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final endDate = ref.watch(taskProvider.select((value) => value.endDate));
    final container = ref.watch(translationProvider);
    final formatter = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", container.locale.name);

    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      name: 'dt2',
      initialValue: endDate,
      format: formatter,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: container.translations.taskPage.taskEndDateFieldLabelText,
      ),
      onChanged: (val) async {
        if (val != null) {
          final task = ref.read(taskProvider);
          final project = ref.read(projectProvider);
          await project.editTask(task.copyWith(endDate: val));
        }
      },
    );
  }
}
