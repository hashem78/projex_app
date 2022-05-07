import 'package:flutter/material.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/role_checkbox_tile.dart';

class RolesListView extends StatelessWidget {
  const RolesListView({
    Key? key,
    required this.project,
    required this.user,
  }) : super(key: key);

  final PProject project;
  final PUser user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: project.roles.length,
        itemBuilder: (context, index) {
          final role = project.roles.toList()[index];
          return RoleCheckboxTile(
            role: role,
            project: project,
            user: user,
          );
        },
      ),
    );
  }
}
