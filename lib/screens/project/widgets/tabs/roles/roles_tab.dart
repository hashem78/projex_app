import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/screens/project/widgets/project_roles_listview.dart';
import 'package:projex_app/screens/project/widgets/tabs/roles/widgets/create_role_tile.dart';
import 'package:projex_app/state/editing.dart';

class RolesTab extends ConsumerWidget {
  const RolesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProvider(EditReason.project));
    return Column(
      children: [
        if (isEditing) const CreateRoleTile(),
        const Expanded(
          child: ProjectRolesListView(),
        ),
      ],
    );
  }
}
