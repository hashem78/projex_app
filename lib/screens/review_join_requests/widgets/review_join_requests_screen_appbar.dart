import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/project_provider.dart';

class ReviewJoinRequestsScreenAppBar extends ConsumerWidget {
  const ReviewJoinRequestsScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return SliverAppBar(
      title: Text(project.name),
      expandedHeight: 0.25.sh,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Review Join Requests'),
            if (project.joinRequests.isNotEmpty)
              Text(
                '${project.joinRequests.length} join requests(s)',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            if (project.joinRequests.isEmpty)
              Text(
                'There are no join requests',
                style: Theme.of(context).textTheme.labelSmall,
              ),
          ],
        ),
      ),
    );
  }
}
