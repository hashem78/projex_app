import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskTitleTextField extends ConsumerWidget {
  const SubTaskTitleTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final title = ref.watch(subTaskProvider.select((value) => value.title));

    return FormBuilderTextField(
      key: ValueKey(project),
      initialValue: title,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.minLength(10),
          FormBuilderValidators.required(),
        ],
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (val) async {
        if (val == null) return;
        if (val.length >= 5) {
          final task = ref.read(taskProvider);

          final project = ref.read(projectProvider);
          final tid = ref.read(selectedTaskProvider);
          await project.editSubTask(
            tid,
            task.copyWith(title: val),
          );
        }
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'SubTask Title',
        hintText: title,
      ),
      name: '',
    );
  }
}
