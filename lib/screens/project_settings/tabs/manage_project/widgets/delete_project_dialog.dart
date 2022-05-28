import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/project_provider.dart';

class DeleteProjectDialog extends ConsumerWidget {
  const DeleteProjectDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onPressed: () {
            final pid = ref.read(selectedProjectProvider);
            context.go('/');
            FirebaseFirestore.instance.doc('/projects/$pid').delete();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
