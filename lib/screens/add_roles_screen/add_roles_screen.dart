import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/add_roles_screen/add_roles_appbar_title.dart';
import 'package:projex_app/screens/add_roles_screen/roles_listview.dart';
import 'package:projex_app/screens/profile/widgets/puser_builder.dart';
import 'package:projex_app/screens/project_screen/widgets/project_builder.dart';

class AddRolesScreen extends ConsumerWidget {
  final String pid;
  final String uid;
  const AddRolesScreen({
    Key? key,
    required this.pid,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PUserBuilder.fromUid(
      uid: uid,
      builder: (context, user) {
        return PProjectBuilder(
          pid: pid,
          builder: (context, project) {
            return Scaffold(
              appBar: AppBar(
                title: AddRolesAppBarTitle(
                  userName: user.name,
                  projectName: project.name,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Text("Roles"),
                  ),
                  RolesListView(
                    project: project,
                    user: user,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
