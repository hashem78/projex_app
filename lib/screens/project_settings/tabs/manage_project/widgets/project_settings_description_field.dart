import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsDescriptionField extends HookConsumerWidget {
  const ProjectSettingsDescriptionField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasError = useValueNotifier(false);
    final controller = useTextEditingController();
    return TextFormField(
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      onChanged: (val) {
        final project = ref.read(projectProvider);
        print(val.length);
        if (val.isEmpty) {
          hasError.value = false;
          return;
        }
        if (val.length >= 10) {
          hasError.value = false;
          project.updateField('description', val);
        } else {
          hasError.value = true;
        }
      },
      decoration: InputDecoration(
        hintText: ref.watch(projectProvider.select((value) => value.description)),
        labelText: 'Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: useValueListenable(hasError)
            ? controller.text.length < 10
                ? 'Description has to be atleast 10 characters'
                : null
            : null,
      ),
    );
  }
}
