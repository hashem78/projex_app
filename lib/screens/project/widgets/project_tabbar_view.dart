import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/members_tab.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/tasks_tab.dart';

class ProjectTabBarView extends ConsumerWidget {
  const ProjectTabBarView({
    Key? key,
    required this.project,
  }) : super(key: key);

  final PProject project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabBarView(
      children: [
        const TasksTab(),
        MembersTab(project: project),
      ],
    );
  }
}
