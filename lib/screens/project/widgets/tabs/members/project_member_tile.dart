import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_profile_image.dart';
import 'package:projex_app/screens/project/widgets/project_builder.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_role_list.dart';

class ProjectMemberTile extends StatelessWidget {
  final PProject? project;
  final String? pid;
  final PUser user;
  final bool showRoles;
  const ProjectMemberTile({
    Key? key,
    required this.project,
    required this.user,
    this.showRoles = true,
  })  : pid = null,
        super(key: key);

  const ProjectMemberTile.fromPID({
    Key? key,
    required this.user,
    required this.pid,
    this.showRoles = true,
  })  : project = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (project != null) {
      return _buildWIdget(context, project!);
    } else {
      return PProjectBuilder(
        pid: pid!,
        builder: (context, project) {
          return _buildWIdget(context, project);
        },
      );
    }
  }

  Widget _buildWIdget(BuildContext context, PProject project) {
    return InkWell(
      onTap: () {
        context.push('/profile/${user.id}', extra: user);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            MemberTileProfileImage(link: user.profilePicture?.link ?? ""),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  if (showRoles)
                    MemberRoleList(
                      project: project,
                      user: user,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
