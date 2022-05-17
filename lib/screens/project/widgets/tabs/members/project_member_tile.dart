import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_profile_image.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_role_list.dart';

class ProjectMemberTile extends StatelessWidget {
  final PUser user;
  final bool showRoles;
  const ProjectMemberTile({
    super.key,
    this.showRoles = true,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
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
