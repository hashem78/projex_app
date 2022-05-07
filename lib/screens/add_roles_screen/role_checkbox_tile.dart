import 'package:flutter/material.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role/role.dart';
import 'package:projex_app/models/user_model/user_model.dart';

class RoleCheckboxTile extends StatelessWidget {
  const RoleCheckboxTile({
    Key? key,
    required this.role,
    required this.project,
    required this.user,
  }) : super(key: key);

  final Role role;
  final PProject project;
  final PUser user;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(role.name),
      value: project.userRoleMap[user.id]?.contains(role.id),
      onChanged: (val) async {
        if (!val!) {
          await user.removeRoles(
            projectId: project.id,
            userId: user.id,
            rolesToRemove: [role],
          );
        } else {
          await user.assignRoles(
            projectId: project.id,
            userId: user.id,
            rolesToAssign: [role],
          );
        }
      },
    );
  }
}
