import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/permission/permission_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class ManageTabMemberTile extends ConsumerWidget {
  const ManageTabMemberTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ProjectMemberTile(
            onTap: () {
              final user = ref.read(userProvider);
              context.push('/profile/${user.id}');
            },
            showRoles: false,
            allowAddingRoles: false,
          ),
        ),
        if (!role.permissions.contains(const PPermission.owner()))
          IconButton(
            onPressed: () async {
              final project = ref.read(projectProvider);
              final user = ref.read(userProvider);

              await project.removeRoleFromUser(
                userId: user.id,
                role: role,
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
