import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectProgressIndicator extends StatelessWidget {
  final int progress;
  const ProjectProgressIndicator({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        //progressColor: Colors.blue,
        percent: progress / 100,
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
          "$progress%",
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
