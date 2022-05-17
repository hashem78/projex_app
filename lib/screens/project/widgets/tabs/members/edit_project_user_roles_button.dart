import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/editing.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class EditProjectUserRolesButton extends ConsumerWidget {
  const EditProjectUserRolesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProvider(EditReason.project));

    return GestureDetector(
      onTap: () {
        final uid = ref.read(selectedUserProvider);
        final pid = ref.read(selectedProjectProvider);
        context.push('/project/$pid/addRolesToUser?uid=$uid');
      },
      child: isEditing
          ? Padding(
              padding: const EdgeInsetsDirectional.only(start: 4.0),
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
            )
          : const SizedBox(),
    );
  }
}
