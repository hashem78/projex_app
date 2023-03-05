import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProfilePageAppBar extends ConsumerWidget {
  const HomeProfilePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const banner = "https://picsum.photos/400/500";
    
    return SliverAppBar(
      toolbarHeight: 0.25.sh,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: banner,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
