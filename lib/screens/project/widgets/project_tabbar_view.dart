import 'package:flutter/material.dart';

import 'package:projex_app/screens/project/widgets/tabs/members/members_tab.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/tasks_tab.dart';

class ProjectTabBarView extends StatelessWidget {
  const ProjectTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        TasksTab(),
        MembersTab(),
      ],
    );
  }
}
