import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectProgressIndicator extends ConsumerWidget {
  const ProjectProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(projectProvider.select((value) => value.progress));

    return SizedBox(
      width: 0.5.sw,
      height: 0.3.sh,
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1000,
        radius: 320.r,
        reverse: true,
        lineWidth: 15,
        circularStrokeCap: CircularStrokeCap.round,
        percent: progress.toDouble(),
        rotateLinearGradient: true,
        linearGradient: LinearGradient(
          colors: [
            Colors.blue.shade100,
            Colors.blue.shade200,
            Colors.blue.shade300,
            Colors.blue.shade400,
            Colors.blue.shade500,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.blue.shade800,
            Colors.blue.shade900,
          ],
        ),
        center: Text(
          "${(progress * 100).round()}%",
          maxLines: 1,
          style: TextStyle(
            fontSize: 150.sp,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
