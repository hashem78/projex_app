import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/review_join_requests/widgets/project_join_request_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class JoinRequestsList extends ConsumerWidget {
  const JoinRequestsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinRequests = ref.watch(projectProvider).joinRequests;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: joinRequests.length,
        (context, index) {
          final uid = joinRequests.toList()[index];
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(uid),
            ],
            child: const ProjectJoinRequestTile(),
          );
        },
      ),
    );
  }
}
