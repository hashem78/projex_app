import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_profile_image.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/member_role_list.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/remove_member_from_project_button.dart';
import 'package:projex_app/state/user_provider.dart';

class ProjectMemberTile extends ConsumerWidget {
  final bool showRoles;
  final bool allowAddingRoles;
  final bool showRemoveFromProjectButton;
  final VoidCallback? onTap;
  const ProjectMemberTile({
    super.key,
    this.showRoles = true,
    required this.allowAddingRoles,
    this.showRemoveFromProjectButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return InkWell(
      onTap: onTap,
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (showRoles) MemberRoleList(allowAddingRoles: allowAddingRoles),
                ],
              ),
            ),
            if (showRemoveFromProjectButton) const Spacer(),
            if (showRemoveFromProjectButton) const RemoveMemberFromProjectButton()
          ],
        ),
      ),
    );
  }
}
