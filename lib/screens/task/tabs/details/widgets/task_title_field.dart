import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskTitleTextField extends ConsumerWidget {
  const TaskTitleTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final title = ref.watch(taskProvider.select((value) => value.title));

    return FormBuilderTextField(
      key: ValueKey(project),
      initialValue: title,
      onChanged: (val) async {
        if (val != null) {
          if (val.length >= 5) {
            final task = ref.read(taskProvider);

            final project = ref.read(projectProvider);
            await project.editTask(task.copyWith(title: val));
          }
        }
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Task Title',
        hintText: title,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(5),
        ],
      ),
      name: '',
    );
  }
}
