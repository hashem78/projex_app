import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/manage_groups_tab.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/manage_project_tab.dart';
import 'package:projex_app/screens/project_settings/tabs/members/manage_members_tab.dart';
import 'package:projex_app/screens/project_settings/tabs/roles/roles_tab.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsScreen extends ConsumerWidget {
  const ProjectSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(projectProvider.select((value) => value.name));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  title: Text('$name Settings'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Manage'),
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
                ManageProjectTab(),
                ManageMembersTab(),
                RolesTab(),
                ManageGroupsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
