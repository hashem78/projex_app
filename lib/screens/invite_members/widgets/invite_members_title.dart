import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/locale.dart';

class InviteMembersScreenTitle extends ConsumerWidget {
  const InviteMembersScreenTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.inviteMembersPage;
    return Text(translations.title);
  }
}
