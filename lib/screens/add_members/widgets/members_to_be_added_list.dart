import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/add_members.dart';

class MembersToBeAddedList extends ConsumerWidget {
  const MembersToBeAddedList({
    Key? key,
    required this.pid,
  }) : super(key: key);

  final String pid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(memberEmailsProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) {
        final user = members.toList()[index];
        return Row(
          children: [
            Expanded(
              child: ProjectMemberTile.fromPID(
                pid: pid,
                user: user,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              color: Colors.red,
              onPressed: () {
                ref.read(memberEmailsProvider.notifier).remove(user);
              },
            )
          ],
        );
      },
    );
  }
}
