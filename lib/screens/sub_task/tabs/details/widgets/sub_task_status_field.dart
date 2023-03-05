import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/task_status/task_status.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_status_radio.dart';
import 'package:projex_app/state/locale.dart';

class SubTaskStatusField extends ConsumerWidget {
  const SubTaskStatusField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.taskPage;

    return InputDecorator(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: translations.taskStatusLabelText,
      ),
      child: Column(
        children: PTaskStatus.values
            .map(
              (e) => SubTaskStatusRadio(defaultStatus: e),
            )
            .toList(),
      ),
    );
  }
}
