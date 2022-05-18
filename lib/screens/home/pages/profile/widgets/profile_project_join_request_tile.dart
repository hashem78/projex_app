import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class ProfilePageProjectJoinRequestTile extends ConsumerWidget {
  const ProfilePageProjectJoinRequestTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Center(
              child: Text(
                project.name.isNotEmpty ? project.name[0] : "",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Text(
              project.name,
              style: TextStyle(
                fontSize: 50.sp,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              final user = ref.read(authProvider);
              await user.cancelJoinRequest(project.id);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
