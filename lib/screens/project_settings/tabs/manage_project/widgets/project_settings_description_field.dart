import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsDescriptionField extends HookConsumerWidget {
  const ProjectSettingsDescriptionField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final description = ref.watch(projectProvider.select((value) => value.description));
    return FormBuilderTextField(
      initialValue: description,
      key: ValueKey(project),
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (val) async {
        final project = ref.read(projectProvider);
        if (val == null) {
          return;
        }
        if (val.length >= 5) {
          await project.updateField('description', val);
        }
      },
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(5),
        ],
      ),
      decoration: InputDecoration(
        hintText: description,
        labelText: 'Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      name: '',
    );
  }
}
