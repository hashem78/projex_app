import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/user_model/user_model.dart';

class ProfileScreenImage extends ConsumerWidget {
  const ProfileScreenImage({
    required this.user,
    this.borderWidth = 4,
    this.width = 120,
    this.height = 120,
    Key? key,
  }) : super(key: key);
  final double width;
  final double height;
  final PUser user;
  final double borderWidth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CachedNetworkImage(
      imageUrl: user.profilePicture?.link ?? "https://picsum.photos/200/300",
      imageBuilder: (context, imageProvider) {
        return AnimatedContainer(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              width: borderWidth,
              color: Theme.of(context).canvasColor,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
              ),
            ],
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
          duration: const Duration(seconds: 1),
        );
      },
    );
  }
}
