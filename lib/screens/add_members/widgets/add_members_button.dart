import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/add_members.dart';
import 'package:projex_app/state/auth.dart';

class AddMembersButton extends ConsumerWidget {
  const AddMembersButton({
    Key? key,
    required this.pid,
  }) : super(key: key);

  final String pid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberIds = ref.watch(memberEmailsProvider);
    final user = ref.watch(authProvider)!;
    return SizedBox(
      width: 1.sw,
      child: TextButton(
        onPressed: memberIds.isNotEmpty
            ? () async {
                final memberIds = ref
                    .read(memberEmailsProvider)
                    .map(
                      (e) => e.id,
                    )
                    .toList(
                      growable: false,
                    );
                await user.addMembersToProject(projectId: pid, memberIds: memberIds);
                context.pop();
              }
            : null,
        child: const Text("Add members"),
      ),
    );
  }
}
