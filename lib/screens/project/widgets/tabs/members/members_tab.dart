import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';

import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class MembersTab extends ConsumerWidget {
  const MembersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: project.memberIds.length,
            (context, index) {
              final uid = project.memberIds.toList()[index];

              return ProviderScope(
                overrides: [
                  selectedUserProvider.overrideWithValue(uid),
                ],
                child: Consumer(builder: (context, ref, _) {
                  return ProjectMemberTile(
                    allowAddingRoles: false,
                    onTap: () {
                      final project = ref.read(projectProvider);
                      context.push('/project/${project.id}/chatWith/$uid');
                    },
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
