import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/project_provider.dart';

class ReviewInvitesScreenAppBar extends ConsumerWidget {
  const ReviewInvitesScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invites = ref.watch(projectProvider).invitations;
    return SliverAppBar(
      expandedHeight: 0.25.sh,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Review Invitations'),
            if (invites.isNotEmpty)
              Text(
                '${invites.length} invitation(s)',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            if (invites.isEmpty)
              Text(
                'There are no invitations',
                style: Theme.of(context).textTheme.labelSmall,
              ),
          ],
        ),
      ),
    );
  }
}
