import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.profilePicture,
    this.borderWidth = 2,
    this.size,
  }) : super(key: key);

  final PProfilePicture profilePicture;
  final double borderWidth;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: profilePicture.link,
      imageBuilder: (context, imageProvider) {
        return AnimatedContainer(
          width: size,
          height: size,
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
              fit: BoxFit.cover,
            ),
          ),
          duration: const Duration(
            milliseconds: 250,
          ),
        );
      },
    );
  }
}
