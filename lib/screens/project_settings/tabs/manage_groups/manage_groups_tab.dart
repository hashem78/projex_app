import 'package:flutter/material.dart';

import 'package:projex_app/screens/project_settings/tabs/manage_groups/widgets/create_group_tile.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/widgets/group_list.dart';

class ManageGroupsTab extends StatelessWidget {
  const ManageGroupsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CreateGroupTile(),
        ),
        ProjectSettingsGroupList(),
      ],
    );
  }
}
