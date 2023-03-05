import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/add_members.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/router_provider.dart';

class InviteMembersButton extends ConsumerWidget {
  const InviteMembersButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberIds = ref.watch(memberEmailsProvider);
    final translations = ref.watch(translationProvider).translations.inviteMembersPage;

    return SliverToBoxAdapter(
      child: SizedBox(
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
                  for (final id in memberIds) {
                    await project.sendInvitationTo(id);
                  }
                  ref.read(routerProvider).pop();
                }
              : null,
          child: Text(translations.inviteMembersButtonText),
        ),
      ),
    );
  }
}
