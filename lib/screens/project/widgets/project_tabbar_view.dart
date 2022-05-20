import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/screens/project/widgets/tabs/groups/project_groups_tab.dart';

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
        GroupsTab(),
      ],
    );
  }
}
