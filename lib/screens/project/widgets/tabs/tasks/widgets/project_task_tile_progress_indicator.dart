import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:projex_app/state/task_provider.dart';

class ProjectTaskTileProgressIndicator extends ConsumerWidget {
  const ProjectTaskTileProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(taskProvider.select((value) => value.progress));
    return CircularPercentIndicator(
      radius: 65.r,
      lineWidth: 5,
      center: Text(
        '${(progress * 100).round()}%',
        maxLines: 1,
      ),
      percent: progress.toDouble(),
      reverse: true,
      progressColor: Colors.blue,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
