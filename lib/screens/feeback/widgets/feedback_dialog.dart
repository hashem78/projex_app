import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/models/feedback_model/feedback_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:uuid/uuid.dart';

class FeedBackDialog extends HookConsumerWidget {
  const FeedBackDialog({
    this.initialValue,
    Key? key,
  }) : super(key: key);
  final PFeedBack? initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController()..text = initialValue?.text ?? '';
    final errorText = useValueNotifier<String?>(null);
    ref.watch(projectProvider);

    return SizedBox(
      width: 0.8.sw,
      child: AlertDialog(
        title: const Text('Add feedback'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isEmpty) {
                errorText.value = 'Feedback cannot be empty';
              } else if (controller.text.length < 5) {
                errorText.value = 'Feedback has to be atleast 5 characters long';
              } else {
                final project = ref.read(projectProvider);
                final tid = ref.read(selectedTaskProvider);
                final uid = ref.read(authProvider).id;
                project.feedBackOnTask(
                  tid,
                  initialValue?.copyWith(text: controller.text) ??
                      PFeedBack(
                        id: const Uuid().v4(),
                        creatorId: uid,
                        text: controller.text,
                      ),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Feedback',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorText: useValueListenable(errorText),
          ),
          maxLines: 5,
        ),
      ),
    );
  }
}
