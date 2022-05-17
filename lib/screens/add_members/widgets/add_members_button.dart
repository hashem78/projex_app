import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/add_members.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/router_provider.dart';

class AddMembersButton extends ConsumerWidget {
  const AddMembersButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberIds = ref.watch(memberEmailsProvider);
    final user = ref.watch(authProvider)!;
    return SizedBox(
      width: 1.sw,
      child: TextButton(
        onPressed: memberIds.isNotEmpty
            ? () async {
                final project = ref.read(projectProvider);
                final memberIds = ref
                    .read(memberEmailsProvider)
                    .map(
                      (e) => e.id,
                    )
                    .toList(
                      growable: false,
                    );
                await user.addMembersToProject(
                  projectId: project.id,
                  memberIds: memberIds,
                );
                ref.read(routerProvider).pop();
              }
            : null,
        child: const Text("Add members"),
      ),
    );
  }
}
