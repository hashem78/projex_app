import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/project_provider.dart';

final formatter = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");

class ProjectSettingsStartDateField extends ConsumerWidget {
  const ProjectSettingsStartDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final date = ref.watch(projectProvider.select((value) => value.startDate));
    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      initialValue: date,
      decoration: const InputDecoration(
        labelText: 'Start Date',
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
