import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/editing.dart';

class AddRolesButton extends ConsumerWidget {
  const AddRolesButton({
    Key? key,
    required this.pid,
    required this.uid,
  }) : super(key: key);
  final String pid;
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(allowEditingProjectProvider);

    return GestureDetector(
      onTap: () {
        context.push('/project/addRolesToUser?pid=$pid&uid=$uid');
      },
      child: isEditing
          ? Badge(
              shape: BadgeShape.square,
              toAnimate: false,
              badgeColor: Colors.blue,
              borderRadius: BorderRadius.circular(8),
              badgeContent: Row(
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ),
                  16.horizontalSpace,
                  const Text(
                    'Edit Roles',
                    style: TextStyle(color: Colors.white),
                  ),
                  16.horizontalSpace,
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
