import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/profile/widgets/puser_builder.dart';
import 'package:projex_app/state/add_members_state.dart';

class AddMembersButton extends ConsumerWidget {
  const AddMembersButton({
    Key? key,
    required this.pid,
  }) : super(key: key);

  final String pid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberIds = ref.watch(memberEmailsProvider);
    return SizedBox(
      width: 1.sw,
      child: PUserBuilder.fromCurrent(builder: (context, user) {
        return TextButton(
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
        );
      }),
    );
  }
}
