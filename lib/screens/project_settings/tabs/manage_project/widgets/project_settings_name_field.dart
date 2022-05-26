import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsNameField extends HookConsumerWidget {
  const ProjectSettingsNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider.select((value) => value.id));
    final name = ref.watch(projectProvider.select((value) => value.name));
    return FormBuilderTextField(
      key: ValueKey(project),
      initialValue: name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (val) async {
        final project = ref.read(projectProvider);
        if (val == null) {
          return;
        }
        if (val.length >= 5) {
          await project.updateField('name', val);
        }
      },
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(5),
        ],
      ),
      decoration: InputDecoration(
        hintText: name,
        errorStyle: const TextStyle(height: 0),
        labelText: 'Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      name: '',
    );
  }
}
