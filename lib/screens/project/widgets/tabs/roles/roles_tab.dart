import 'package:flutter/material.dart';

import 'package:projex_app/screens/project/widgets/project_roles_listview.dart';
import 'package:projex_app/screens/project/widgets/tabs/roles/widgets/create_role_tile.dart';

class RolesTab extends StatelessWidget {
  const RolesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CreateRoleTile(),
        Expanded(
          child: ProjectRolesListView(),
        ),
      ],
    );
  }
}
