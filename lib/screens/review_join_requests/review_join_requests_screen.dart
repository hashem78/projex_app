import 'package:flutter/material.dart';
import 'package:projex_app/screens/review_join_requests/widgets/join_requests_list.dart';
import 'package:projex_app/screens/review_join_requests/widgets/review_join_requests_screen_appbar.dart';

class ReviewJoinRequestsScreen extends StatelessWidget {
  const ReviewJoinRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          ReviewJoinRequestsScreenAppBar(),
          JoinRequestsList(),
        ],
      ),
    );
  }
}
