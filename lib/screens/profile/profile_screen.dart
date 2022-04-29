import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/profile/widgets/profile_screen_appbar.dart';

import 'package:projex_app/state/auth.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(pUserProvider(uid));

    return Scaffold(
      body: CustomScrollView(
        slivers: userFuture.when(
          data: (user) {
            if (user != null) {
              return [
                ProfileScreenAppBar(user: user),
                SliverPadding(
                  padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
                  sliver: ProfileCard(user: user),
                ),
              ];
            }
            return const [];
          },
          error: (_, __) => const [],
          loading: () => const [],
        ),
      ),
    );
  }
}
