import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/editing.dart';
import 'package:projex_app/state/image_picker/image_picker.dart';

class EditableProfileImage extends ConsumerWidget {
  const EditableProfileImage({
    this.borderWidth = 4,
    this.width = 120,
    this.height = 120,
    Key? key,
  }) : super(key: key);
  final double width;
  final double height;
  final double borderWidth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final isEditing = ref.watch(editingProvider(EditReason.profile));
    return GestureDetector(
      onTap: isEditing ? () async => await _changePfp(user.id, ref) : null,
      child: ProfileImage(
        profilePicture: user.profilePicture,
      ),
    );
  }

  Future<void> _changePfp(String uid, WidgetRef ref) async {
    final images = await ref
        .read(
          imagePickerProvider.notifier,
        )
        .pick(
          ImageSource.gallery,
        );
    if (images.isNotEmpty) {
      final imageFile = images.first;
      final sref = FirebaseStorage.instance.ref();
      final imref = sref.child('users/$uid/profile/profile.jpg');
      await imref.putData(await imageFile.readAsBytes());
      final link = await imref.getDownloadURL();
      await FirebaseFirestore.instance.doc('users/$uid').update(
        {
          'profilePicture': {
            'link': link,
            'width': 120,
            'height': 120,
          },
        },
      );
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(link);
    }
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.profilePicture,
    this.borderWidth = 4,
  }) : super(key: key);

  final PProfilePicture profilePicture;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: profilePicture.link,
      imageBuilder: (context, imageProvider) {
        return AnimatedContainer(
          width: profilePicture.width?.toDouble() ?? 120,
          height: profilePicture.width?.toDouble() ?? 120,
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
