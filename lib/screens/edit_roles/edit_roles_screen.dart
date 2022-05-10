import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/edit_roles/edit_role_tabbar_view.dart';
import 'package:projex_app/screens/edit_roles/edit_roles_appbar.dart';
import 'package:projex_app/screens/edit_roles/widgets/edit_roles_end_drawer.dart';
import 'package:projex_app/screens/edit_roles/widgets/role_builder.dart';

class EditRoleScreen extends ConsumerWidget {
  final String roleId;
  final PProject project;
  const EditRoleScreen({
    Key? key,
    required this.roleId,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PRoleBuilder(
      pid: project.id,
      rid: roleId,
      builder: (context, role) {
        return Scaffold(
          endDrawer: EditRolesEndDrawer(
            project: project,
          ),
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  EditRoleScreenAppBar(role: role),
                ];
              },
              body: EditRoleTabBarView(
                project: project,
                role: role,
              ),
            ),
          ),
        );
      },
    );
  }
}
