import 'package:flutter/material.dart';

import 'package:projex_app/screens/project/widgets/tabs/groups/project_groups_tab.dart';

import 'package:projex_app/screens/project/widgets/tabs/members/members_tab.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/tasks_tab.dart';

class ProjectTabBarView extends StatelessWidget {
  const ProjectTabBarView({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        TasksTab(),
        MembersTab(),
        GroupsTab(),
      ],
    );
  }
}
