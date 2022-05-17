import 'package:flutter/material.dart';
import 'package:projex_app/screens/project/widgets/project_roles_listview.dart';

class EditRolesEndDrawer extends StatelessWidget {
  const EditRolesEndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: ProjectRolesListView(
        showDelete: false,
      ),
    );
  }
}
