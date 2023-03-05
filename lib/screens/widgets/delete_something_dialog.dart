import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/state/locale.dart';

class DeleteSomethingDialog extends ConsumerWidget {
  const DeleteSomethingDialog({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.deleteSomethingDialog;
    return AlertDialog(
      content: Text(
        translations.deleteRoleDialogConfirmationText(name: name),
      ),
      title: Text(translations.deleteRoleDialogTitleText(name: name)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(translations.deleteRoleDialogConfirmationButtonText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(translations.deleteRoleDialogCancellationButtonText),
        ),
      ],
    );
  }
}
