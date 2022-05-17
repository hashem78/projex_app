import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/add_members.dart';
import 'package:projex_app/state/user_provider.dart';

class MembersToBeAddedList extends ConsumerWidget {
  const MembersToBeAddedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(memberEmailsProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) {
        final user = members.toList()[index];
        return ProviderScope(
          overrides: [
            selectedUserProvider.overrideWithValue(user.id),
          ],
          child: Row(
            children: [
              const Expanded(
                child: ProjectMemberTile(),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.red,
                onPressed: () {
                  ref.read(memberEmailsProvider.notifier).remove(user);
                },
              )
            ],
          ),
        );
      },
    );
  }
}