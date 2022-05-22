import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/available_groups.dart';
import 'package:projex_app/state/project_provider.dart';

class GroupsTab extends ConsumerStatefulWidget {
  const GroupsTab({Key? key}) : super(key: key);

  @override
  ConsumerState<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends ConsumerState<GroupsTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final groupsFuture = ref.watch(availableGroupsProvider);
    ref.listen(
      projectProvider.select((p) => p.userRoleMap),
      (before, after) {
        ref.refresh(availableGroupsProvider);
      },
    );
    return groupsFuture.when(
      data: (groups) {
        if (groups.isNotEmpty) {
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(
                onTap: () {
                  final projectId = ref.read(selectedProjectProvider);
                  context.push('/project/$projectId/groupChat/${group.id}');
                },
                title: Text(group.name),
              );
            },
          );
        } else {
          return const Center(
            child: Text('You are not part of any groups'),
          );
        }
      },
      error: (_, __) {
        debugPrint(_.toString());
        debugPrint(__.toString());

        return const Center(
          child: Text('Error'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
