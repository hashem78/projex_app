import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/screens/edit_roles/edit_role_tabbar_view.dart';
import 'package:projex_app/screens/edit_roles/edit_roles_appbar.dart';
import 'package:projex_app/screens/edit_roles/widgets/edit_roles_end_drawer.dart';
import 'package:projex_app/screens/edit_roles/widgets/role_builder.dart';
import 'package:projex_app/state/project_provider.dart';

class EditRoleScreen extends ConsumerWidget {
  final String roleId;

  const EditRoleScreen({
    Key? key,
    required this.roleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pid = ref.watch(selectedProjectProvider);
    return PRoleBuilder(
      pid: pid,
      rid: roleId,
      builder: (context, role) {
        return Scaffold(
          endDrawer: const EditRolesEndDrawer(),
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  EditRoleScreenAppBar(role: role),
                ];
              },
              body: EditRoleTabBarView(
                role: role,
              ),
            ),
          ),
        );
      },
    );
  }
}
