import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskDueDateField extends ConsumerWidget {
  const SubTaskDueDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final dueDate = ref.watch(subTaskProvider.select((value) => value.dueDate));
    final container = ref.watch(translationProvider);
    final locale = container.locale;
    final translations = container.translations.taskPage;

    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      name: 'dt3',
      initialValue: dueDate,
      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", locale.name),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: translations.taskDueDateFieldLabelText,
      ),
      onChanged: (val) async {
        final project = ref.read(projectProvider);
        final tid = ref.read(selectedTaskProvider);
        final subTask = ref.read(subTaskProvider);
        await project.editSubTask(
          tid,
          subTask.copyWith(dueDate: val),
        );
      },
    );
  }
}
