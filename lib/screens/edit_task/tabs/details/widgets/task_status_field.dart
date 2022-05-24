import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/task_status/task_status.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_status_radio.dart';

class TaskStatusField extends ConsumerWidget {
  const TaskStatusField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InputDecorator(
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Status',
      ),
      child: Column(
        children: PTaskStatus.values
            .map(
              (e) => TaskStatusRadio(defaultStatus: e),
            )
            .toList(),
      ),
    );
  }
}
