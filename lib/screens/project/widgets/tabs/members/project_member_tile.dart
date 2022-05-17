import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_profile_image.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_role_list.dart';
import 'package:projex_app/state/user_provider.dart';

class ProjectMemberTile extends ConsumerWidget {
  final bool showRoles;
  const ProjectMemberTile({
    super.key,
    this.showRoles = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return InkWell(
      onTap: () {
        final user = ref.read(userProvider);
        context.push('/profile/${user.id}');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            MemberTileProfileImage(link: user.profilePicture.link),
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
                  if (showRoles) const MemberRoleList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
