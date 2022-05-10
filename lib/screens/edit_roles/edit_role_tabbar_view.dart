import 'package:flutter/material.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/display_tab.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/manage/manage_tab.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/permissions/permissions_tab.dart';

class EditRoleTabBarView extends StatelessWidget {
  const EditRoleTabBarView({
    Key? key,
    required this.project,
    required this.role,
  }) : super(key: key);

  final PProject project;
  final PRole role;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        DisplayTab(
          project: project,
          role: role,
        ),
        PermissionsTab(
          project: project,
          role: role,
        ),
        ManageTab(
          project: project,
          role: role,
        ),
      ],
    );
  }
}
