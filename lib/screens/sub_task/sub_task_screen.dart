import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/screens/sub_task/tabs/assigness/sub_task_assignees_tab.dart';
import 'package:projex_app/screens/sub_task/tabs/details/sub_task_details_tab.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';

class SubTaskScreen extends ConsumerWidget {
  const SubTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final task = ref.watch(subTaskProvider);
    return DefaultTabController(
      length: 2,
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
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              SubTaskDetailsTab(),
              SubTaskAssigneesTab(),
            ],
          ),
        ),
      ),
    );
  }
}
