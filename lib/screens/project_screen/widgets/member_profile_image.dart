import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberTileProfileImage extends StatelessWidget {
  const MemberTileProfileImage({
    Key? key,
    required this.link,
  }) : super(key: key);

  final String link;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75.r,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(link),
          ),
        ),
      ),
    );
  }
}
