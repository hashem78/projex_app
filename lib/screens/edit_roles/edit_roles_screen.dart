import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/edit_roles/widgets/role_builder.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/display_tab.dart';

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
          endDrawer: const Drawer(),
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverAppBar(
                    title: Text('Edit Role - ${role.name}'),
                    backgroundColor: Color(int.parse(role.color, radix: 16)),
                    leading: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: 'Display'),
                        Tab(text: 'Permissions'),
                        Tab(text: 'Manage'),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  DisplayTab(
                    project: project,
                    role: role,
                  ),
                  ListView(),
                  ListView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
