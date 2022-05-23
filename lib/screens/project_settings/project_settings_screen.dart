import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/manage_groups_tab.dart';
import 'package:projex_app/screens/project_settings/tabs/members/manage_members_tab.dart';
import 'package:projex_app/screens/project_settings/tabs/roles/roles_tab.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsScreen extends ConsumerWidget {
  const ProjectSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                title: Text('${project.name} Settings'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Members'),
                    Tab(text: 'Roles'),
                    Tab(text: 'Groups'),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ManageMembersTab(),
              RolesTab(),
              ManageGroupsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
