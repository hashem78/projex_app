import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskDescriptionTextField extends ConsumerWidget {
  const SubTaskDescriptionTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final description = ref.watch(subTaskProvider.select((value) => value.description));
    final translations = ref.watch(translationProvider).translations.taskPage;

    return FormBuilderTextField(
      key: ValueKey(project),
      initialValue: description,
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
        if (val.length >= 10) {
          final task = ref.read(taskProvider);

          final project = ref.read(projectProvider);
          final tid = ref.read(selectedTaskProvider);
          await project.editSubTask(
            tid,
            task.copyWith(title: val),
          );
        }
      },
      maxLines: 5,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: translations.taskDescriptionTextFieldLabelText,
        hintText: description,
      ),
      name: '',
    );
  }
}
