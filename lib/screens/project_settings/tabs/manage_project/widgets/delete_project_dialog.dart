import 'package:flutter/material.dart';

class DeleteProjectDialog extends StatelessWidget {
  const DeleteProjectDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete this project?'),
      content: const Text(
        'Are you sure you want to delete this Project? this aciton is irreversable.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
