import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class FeedBackScreenAppBar extends ConsumerWidget {
  const FeedBackScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final task = ref.watch(taskProvider);
    return SliverAppBar(
      title: Text(project.name),
      expandedHeight: 0.25.sh,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Feedback for ${task.title}'),
      ),
    );
  }
}
