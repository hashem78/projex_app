import 'package:flutter/material.dart';

import 'package:projex_app/screens/feeback/widgets/feed_back_screen_fab.dart';
import 'package:projex_app/screens/feeback/widgets/feedback_appbar.dart';
import 'package:projex_app/screens/feeback/widgets/feedback_list.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: FeedBackScreenFAB(),
      body: CustomScrollView(
        slivers: [
          FeedBackScreenAppBar(),
          FeedBackList(),
        ],
      ),
    );
  }
}
