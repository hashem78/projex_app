import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/feedback_model/feedback_model.dart';
import 'package:projex_app/screens/feeback/widgets/feedback_tile.dart';
import 'package:projex_app/state/feed_back_provider.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class FeedBackList extends ConsumerWidget {
  const FeedBackList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pid = ref.read(selectedProjectProvider);
    final tid = ref.read(selectedTaskProvider);
    return FirestoreQueryBuilder<PFeedBack>(
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
    );
  }
}
