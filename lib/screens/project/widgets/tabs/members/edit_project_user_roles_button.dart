import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class EditProjectUserRolesButton extends ConsumerWidget {
  final bool allowEditing;
  const EditProjectUserRolesButton({
    Key? key,
    this.allowEditing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!allowEditing) return const SizedBox();
    return GestureDetector(
      onTap: () {
        final uid = ref.read(selectedUserProvider);
        final pid = ref.read(selectedProjectProvider);
        context.push('/project/$pid/addRolesToUser?uid=$uid');
      },
      child: Badge(
        shape: BadgeShape.square,
        toAnimate: false,
        badgeColor: Colors.blue,
        borderRadius: BorderRadius.circular(8),
        badgeContent: Row(
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
            16.horizontalSpace,
            const Text(
              'Add Roles',
              style: TextStyle(color: Colors.white),
            ),
            16.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
