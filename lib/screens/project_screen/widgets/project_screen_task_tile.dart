import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectScreenTaskTile extends StatelessWidget {
  const ProjectScreenTaskTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Task title",
            style: TextStyle(
              fontSize: 50.sp,
            ),
          ),
          leading: ClipOval(
            child: CircularPercentIndicator(
              radius: 50.r,
              lineWidth: 5,
              percent: .75,
              reverse: true,
              progressColor: Colors.blue,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
        ),
      ),
    );
  }
}
