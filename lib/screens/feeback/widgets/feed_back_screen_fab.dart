import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/feeback/widgets/feedback_dialog.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class FeedBackScreenFAB extends ConsumerWidget {
  const FeedBackScreenFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        final pid = ref.read(selectedProjectProvider);
        final tid = ref.read(selectedTaskProvider);
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
    );
  }
}
