import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/models/feedback_model/feedback_model.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_image.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';
import 'package:uuid/uuid.dart';

class FeedBackScreen extends ConsumerStatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends ConsumerState<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectProvider);
    final pid = ref.watch(selectedProjectProvider);
    final tid = ref.watch(selectedTaskProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ProviderScope(
              overrides: [
                selectedProjectProvider.overrideWithValue(pid),
                selectedTaskProvider.overrideWithValue(tid),
              ],
              child: const FeedBackDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(project.name),
            expandedHeight: 0.25.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Feedback for ${project.name}'),
            ),
          ),
          FirestoreQueryBuilder<PFeedBack>(
            query: FirebaseFirestore.instance
                .collection(
                  '/projects/$pid/tasks/$tid/feedback',
                )
                .withConverter(
                  fromFirestore: (f, _) {
                    if (f.data() == null) {
                      return const PFeedBack();
                    }
                    return PFeedBack.fromJson(f.data()!);
                  },
                  toFirestore: (_, __) => {},
                ),
            builder: (context, snap, _) {
              final feedbacks = snap.docs;
              if (feedbacks.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('There are no feedbacks'),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: feedbacks.length,
                  (context, index) {
                    final feedback = feedbacks[index].data();
                    return ProviderScope(
                      overrides: [
                        selectedUserProvider.overrideWithValue(feedback.creatorId),
                        feedBackProvider.overrideWithValue(feedback),
                      ],
                      child: const FeedBackTile(),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

final feedBackProvider = Provider<PFeedBack>(
  (_) {
    throw UnimplementedError('Override feedback provider');
  },
);

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

class FeedBackDialog extends StatefulHookConsumerWidget {
  const FeedBackDialog({
    this.initialValue,
    Key? key,
  }) : super(key: key);
  final PFeedBack? initialValue;
  @override
  ConsumerState<FeedBackDialog> createState() => _FeedBackDialogState();
}

class _FeedBackDialogState extends ConsumerState<FeedBackDialog> {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController()..text = widget.initialValue?.text ?? '';
    final errorText = useValueNotifier<String?>(null);
    ref.watch(projectProvider);

    return SizedBox(
      width: 1.sw,
      child: AlertDialog(
        title: const Text('Add feedback'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isEmpty) {
                print('here');
                errorText.value = 'Feedback cannot be empty';
              } else if (controller.text.length < 5) {
                errorText.value = 'Feedback has to be atleast 5 characters long';
              } else {
                final project = ref.read(projectProvider);
                final tid = ref.read(selectedTaskProvider);
                final uid = ref.read(authProvider).id;
                project.feedBackOnTask(
                  tid,
                  widget.initialValue?.copyWith(text: controller.text) ??
                      PFeedBack(
                        id: const Uuid().v4(),
                        creatorId: uid,
                        text: controller.text,
                      ),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Feedback',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorText: useValueListenable(errorText),
          ),
          maxLines: 5,
        ),
      ),
    );
  }
}
