import 'package:flutter/material.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/project/widgets/project_roles_listview.dart';

class EditRolesEndDrawer extends StatelessWidget {
  const EditRolesEndDrawer({
    Key? key,
    required this.project,
  }) : super(key: key);

  final PProject project;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ProjectRolesListView(
        project: project,
        showDelete: false,
      ),
    );
  }
}
