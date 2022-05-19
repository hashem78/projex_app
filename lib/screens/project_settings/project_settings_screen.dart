import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                title: Text('${project.name} Settings'),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Manage Members',
                    ),
                    Tab(
                      text: 'Manage Roles',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ManageMembersTab(),
              RolesTab(),
            ],
          ),
        ),
      ),
    );
  }
}
