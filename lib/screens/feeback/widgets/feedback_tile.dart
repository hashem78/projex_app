import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/feeback/widgets/feedback_dialog.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_image.dart';
import 'package:projex_app/state/feed_back_provider.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class FeedBackTile extends ConsumerWidget {
  const FeedBackTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final feedback = ref.watch(feedBackProvider);
    final pid = ref.watch(selectedProjectProvider);
    final tid = ref.watch(selectedTaskProvider);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ProviderScope(
              overrides: [
                selectedProjectProvider.overrideWithValue(pid),
                selectedTaskProvider.overrideWithValue(tid),
              ],
              child: FeedBackDialog(
                initialValue: feedback,
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ProfileImage(
                size: 60,
                borderWidth: 1,
                profilePicture: user.profilePicture,
              ),
            ),
            16.horizontalSpace,
            SizedBox(
              width: 0.6.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 60.sp,
                    ),
                  ),
                  Text(
                    feedback.text,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 40.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                final feedback = ref.read(feedBackProvider);
                final project = ref.read(projectProvider);
                final tid = ref.read(selectedTaskProvider);
                await project.removeFeedBackFromTask(tid, feedback.id);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
