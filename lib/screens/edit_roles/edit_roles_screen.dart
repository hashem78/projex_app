import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/profile/widgets/puser_builder.dart';

class EditRoleScreen extends ConsumerWidget {
  final PRole role;
  final PProject project;
  const EditRoleScreen({
    Key? key,
    required this.role,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PUserBuilder.fromCurrent(
      builder: (context, user) {
        return Scaffold(
          endDrawer: const Drawer(),
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverAppBar(
                    title: Text('Edit Role - ${role.name}'),
                    leading: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: 'Display'),
                        Tab(text: 'Permissions'),
                        Tab(text: 'Manage'),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        TextFormField(
                          initialValue: role.name,
                          decoration: InputDecoration(
                            label: Text(role.name),
                            hintText: role.name,
                          ),
                        ),
                        50.verticalSpace,
                        Divider(),
                      ],
                    ),
                  ),
                  ListView(),
                  ListView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
