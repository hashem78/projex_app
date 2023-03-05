import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsStartDateField extends ConsumerWidget {
  const ProjectSettingsStartDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider.select((value) => value.id));
    final date = ref.watch(projectProvider.select((value) => value.startDate));
    final container = ref.watch(translationProvider);
    final translations = container.translations.projectSettings;
    final locale = container.locale;
    final formatter = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", locale.name);
    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      initialValue: date,
      format: formatter,
      decoration: InputDecoration(
        labelText: translations.manageTabStartDateTitleText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (val) {
        if (val != null) {
          final project = ref.read(projectProvider);
          project.updateField('startDate', val.toIso8601String());
        }
      },
      name: 'start',
    );
  }
}
