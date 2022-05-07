import 'package:flutter/material.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/add_roles_button.dart';
import 'package:projex_app/screens/project/widgets/role_bage.dart';

class MemberRoleList extends StatelessWidget {
  const MemberRoleList({
    Key? key,
    required this.pid,
    required this.roles,
    required this.uid,
  }) : super(key: key);

  final List<PRole> roles;
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
