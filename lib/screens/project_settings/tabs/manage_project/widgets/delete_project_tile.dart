import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/delete_project_dialog.dart';
import 'package:projex_app/state/project_provider.dart';

class DeleteProjectTile extends ConsumerStatefulWidget {
  const DeleteProjectTile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DeleteProjectTile> createState() => _DeleteProjectTileState();
}

class _DeleteProjectTileState extends ConsumerState<DeleteProjectTile> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton.icon(
        onPressed: () async {
          final delete = await showDialog<bool>(
                context: context,
                builder: (context) => const DeleteProjectDialog(),
              ) ??
              false;
          if (delete) {
            final pid = ref.read(selectedProjectProvider);
            await FirebaseFirestore.instance.doc('/projects/$pid').delete();
            if (!mounted) return;
            context.push('/');
          }
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        label: const Text(
          'Delete Project',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
