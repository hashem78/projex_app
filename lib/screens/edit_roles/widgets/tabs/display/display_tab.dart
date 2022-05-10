import 'package:flutter/material.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/color_rows.dart';

class DisplayTab extends StatelessWidget {
  const DisplayTab({
    Key? key,
    required this.project,
    required this.role,
  }) : super(key: key);

  final PProject project;
  final PRole role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TextFormField(
            initialValue: role.name,
            onChanged: (val) async {
              await project.editRole(role.copyWith(name: val));
            },
            decoration: InputDecoration(
              label: const Text('Role name'),
              hintText: role.name,
            ),
          ),
          ColorRows(
            role: role,
            project: project,
          ),
        ],
      ),
    );
  }
}
