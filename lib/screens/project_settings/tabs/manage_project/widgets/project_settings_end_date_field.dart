import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/state/project_provider.dart';

final formatter = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");

class ProjectSettingsEndDateField extends ConsumerWidget {
  const ProjectSettingsEndDateField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider.select((value) => value.id));
    final date = ref.watch(projectProvider.select((value) => value.endDate));
    return FormBuilderDateTimePicker(
      key: ValueKey(project),
      initialValue: date,
      format: formatter,
      decoration: const InputDecoration(
        labelText: 'End Date',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (val) {
        if (val != null) {
          final project = ref.read(projectProvider);
          project.updateField('endDate', val.toIso8601String());
        }
      },
      name: 'end',
    );
  }
}
