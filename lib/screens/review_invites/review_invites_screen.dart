import 'package:flutter/material.dart';
import 'package:projex_app/screens/review_invites/widgets/invitations_list.dart';
import 'package:projex_app/screens/review_invites/widgets/review_invites_screen_appbar.dart';

class ReviewInvitesScreen extends StatelessWidget {
  const ReviewInvitesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          ReviewInvitesScreenAppBar(),
          InvitationsList(),
        ],
      ),
    );
  }
}
