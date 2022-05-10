import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_page_appbar.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const ProfileScreenAppBar(),
        SliverPadding(
          padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
          sliver: const ProfileCard(),
        ),
      ],
    );
  }
}
