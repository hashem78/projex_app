import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';

class ReviewJoinRequestsScreenAppBar extends ConsumerWidget {
  const ReviewJoinRequestsScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final translations = ref.watch(translationProvider).translations.reviewJoinRequestsPage;
    return SliverAppBar(
      title: Text(project.name),
      expandedHeight: 0.25.sh,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translations.title),
            if (project.joinRequests.isNotEmpty)
              Text(
                translations.subTitleJoinRequestsText(number: project.joinRequests.length),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            if (project.joinRequests.isEmpty)
              Text(
                translations.subTitleNoJoinRequestsText,
                style: Theme.of(context).textTheme.labelSmall,
              ),
          ],
        ),
      ),
    );
  }
}
