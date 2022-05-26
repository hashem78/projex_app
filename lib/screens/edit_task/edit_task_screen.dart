import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/screens/edit_task/tabs/assignees/task_assignees_tab.dart';
import 'package:projex_app/screens/edit_task/tabs/details/task_details_tab.dart';
import 'package:projex_app/screens/edit_task/tabs/subtasks/subtasks_tab.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class EditTaskScreen extends ConsumerWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final task = ref.watch(taskProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.name),
                    Text(task.title),
                  ],
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Details'),
                    Tab(text: 'Asignees'),
                    Tab(text: 'Sub tasks'),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              TaskDetailsTab(),
              TaskAssigneesTab(),
              TaskSubTasksTab(),
            ],
          ),
        ),
      ),
    );
  }
}
