import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/locale.dart';

class NumberOfMembersThatHaveRoleTile extends ConsumerWidget {
  const NumberOfMembersThatHaveRoleTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.editRolePage;

    return ListTile(
      leading: const Icon(
        Icons.people,
        color: Colors.blue,
      ),
      title: Text(translations.manageTabMembersHaveThisRoleText(number: role.count)),
    );
  }
}
