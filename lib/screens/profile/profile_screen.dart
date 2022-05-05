import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/profile/widgets/profile_screen_appbar.dart';
import 'package:projex_app/screens/profile/widgets/puser_builder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PUserBuilder.fromUid(
        uid: uid,
        builder: (context, user) {
          return CustomScrollView(
            slivers: [
              ProfileScreenAppBar(user: user),
              SliverPadding(
                padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
                sliver: ProfileCard(user: user),
              ),
            ],
          );
        },
      ),
    );
  }
}
