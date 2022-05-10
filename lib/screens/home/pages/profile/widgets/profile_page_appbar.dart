import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_image.dart';

class ProfileScreenAppBar extends StatelessWidget {
  const ProfileScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const banner = "https://picsum.photos/400/500";
    return SliverAppBar(
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
            child: const ProfileImage(),
          ),
        ],
      ),
    );
  }
}
