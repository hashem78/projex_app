import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskEndDateField extends ConsumerWidget {
  const SubTaskEndDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final task = ref.watch(subTaskProvider);
    final container = ref.watch(translationProvider);
    final translations = container.translations.taskPage;
    final locale = container.locale;
    final formatter = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", locale.name);

    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      name: 'dt2',
      initialValue: task.endDate!,
      format: formatter,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: translations.taskEndDateFieldLabelText,
      ),
      onChanged: (val) async {
        final task = ref.read(taskProvider);

        final project = ref.read(projectProvider);
        final tid = ref.read(selectedTaskProvider);
        await project.editSubTask(
          tid,
          task.copyWith(endDate: val),
        );
      },
    );
  }
}
