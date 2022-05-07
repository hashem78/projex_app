import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/profile/widgets/profile_screen_appbar.dart';
import 'package:projex_app/screens/profile/widgets/puser_builder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen.fromCurrent({
    Key? key,
  })  : uid = null,
        user = null,
        super(key: key);

  const ProfileScreen.fromUid({
    Key? key,
    required this.uid,
  })  : user = null,
        super(key: key);

  const ProfileScreen.fromUser({
    Key? key,
    required this.user,
  })  : uid = null,
        super(key: key);

  final String? uid;
  final PUser? user;

  @override
  Widget build(BuildContext context) {
    final isFromCurrent = uid == null && user == null;
    final isFromUid = uid != null && user == null;

    if (isFromCurrent) {
      return PUserBuilder.fromCurrent(
        builder: (_, user) {
          final isInstructor = user.map(
            student: (_) => false,
            instructor: (_) => true,
          );
          return Scaffold(
            floatingActionButton: isInstructor
                ? SpeedDial(
                    icon: Icons.create,
                    activeIcon: Icons.close,
                    children: [
                      SpeedDialChild(
                        backgroundColor: Colors.blue,
                        onTap: () {
                          context.go('/createProject');
                        },
                        child: const Icon(
                          Icons.checklist,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : null,
            body: _buildBody(user),
          );
        },
      );
    } else if (isFromUid) {
      return PUserBuilder.fromUid(
        uid: uid!,
        builder: (_, user) => Scaffold(body: _buildBody(user)),
      );
    } else {
      return Scaffold(
        body: _buildBody(user!),
      );
    }
  }

  Widget _buildBody(PUser user) {
    return CustomScrollView(
      slivers: [
        ProfileScreenAppBar(user: user),
        SliverPadding(
          padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
          sliver: ProfileCard(user: user),
        ),
      ],
    );
  }
}
