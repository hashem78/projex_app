import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/delete_project_dialog.dart';
import 'package:projex_app/state/project_provider.dart';

class DeleteProjectTile extends ConsumerWidget {
  const DeleteProjectTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton.icon(
        onPressed: () {
          final id = ref.read(selectedProjectProvider);
          showDialog(
            context: context,
            builder: (context) => ProviderScope(
              overrides: [
                selectedProjectProvider.overrideWithValue(id),
              ],
              child: const DeleteProjectDialog(),
            ),
          );
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
