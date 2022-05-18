import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_image.dart';
import 'package:projex_app/state/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const banner = "https://picsum.photos/400/500";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 0.25.sh,
            flexibleSpace: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 0.3.sh,
                  width: 1.sw,
                  child: CachedNetworkImage(
                    imageUrl: banner,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -0.070.sh,
                  right: 0,
                  left: 0,
                  child: ProfileImage(
                    profilePicture: user.profilePicture,
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
            sliver: SliverToBoxAdapter(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 0.1.sw),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(
                                  user.email,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 0.1.sw),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
