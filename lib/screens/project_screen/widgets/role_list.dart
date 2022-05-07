import 'package:flutter/material.dart';
import 'package:projex_app/models/role/role.dart';
import 'package:projex_app/screens/project_screen/widgets/add_roles_button.dart';
import 'package:projex_app/screens/project_screen/widgets/role_bage.dart';

class RoleList extends StatelessWidget {
  const RoleList({
    Key? key,
    required this.pid,
    required this.roles,
    required this.uid,
  }) : super(key: key);

  final List<Role> roles;
  final String pid;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      children: [
        ...roles.map((role) => RoleBadge(role: role)),
        AddRolesButton(pid: pid, uid: uid),
      ],
    );
  }
}
