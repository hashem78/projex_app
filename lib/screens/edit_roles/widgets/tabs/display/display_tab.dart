import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/color_rows.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';

class DisplayTab extends ConsumerWidget {
  const DisplayTab({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.editRolePage;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TextFormField(
            initialValue: role.name,
            onChanged: (val) async {
              final project = ref.read(projectProvider);
              await project.editRole(role.copyWith(name: val));
            },
            decoration: InputDecoration(
              label: Text(translations.displayTabRoleNameFieldTitleText),
              hintText: role.name,
            ),
          ),
          ColorRows(role: role),
        ],
      ),
    );
  }
}
