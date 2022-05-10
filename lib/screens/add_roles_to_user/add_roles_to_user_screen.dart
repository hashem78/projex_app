import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/add_roles_appbar_title.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/roles_listview.dart';
import 'package:projex_app/screens/home/widgets/puser_builder.dart';
import 'package:projex_app/screens/project/widgets/project_builder.dart';

class AddRolesToUserScreen extends ConsumerWidget {
  final String pid;
  final String uid;
  const AddRolesToUserScreen({
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
