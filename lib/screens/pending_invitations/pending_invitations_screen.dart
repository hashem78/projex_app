import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/pending_invitations/widgets/pending_invitations_appbar.dart';
import 'package:projex_app/screens/pending_invitations/widgets/pending_invitations_list.dart';
import 'package:projex_app/state/project_provider.dart';

class PendingInvitationsScreen extends ConsumerWidget {
  const PendingInvitationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const PendingInvitationsAppBar(),
          if (project.invitations.isNotEmpty) const PendingInvitationsList(),
        ],
      ),
    );
  }
}
