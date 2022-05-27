import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/group_chat.dart';

class EditChatRoleListTile extends ConsumerWidget {
  const EditChatRoleListTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupChatProvider);
    return CheckboxListTile(
      value: group.allowedRoleIds.contains(role.id),
      title: Text(role.name),
      onChanged: (val) {
        final notifier = ref.watch(groupChatProvider.notifier);
        if (val!) {
          notifier.addRole(role.id);
        } else {
          notifier.removeRole(role.id);
        }
      },
    );
  }
}
