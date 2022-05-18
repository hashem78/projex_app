import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/project_provider.dart';

class PendingInvitationsAppBar extends ConsumerWidget {
  const PendingInvitationsAppBar({
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
            const Text('Pending Invitations'),
            if (project.invitations.isNotEmpty)
              Text(
                '${project.invitations.length} invitations(s)',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            if (project.invitations.isEmpty)
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
