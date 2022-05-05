import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/screens/registration/registration_screen.dart';
import 'package:projex_app/state/auth.dart';
import 'package:path/path.dart' as path;
import 'package:projex_app/state/locale.dart';

class RegistrationButton extends ConsumerWidget {
  const RegistrationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return TextButton(
      onPressed: () async {
        final isValid = builderKey.currentState!.validate();
        if (isValid) {
          final auth = FirebaseAuth.instance;
          final storage = FirebaseStorage.instance;
          final db = FirebaseFirestore.instance;
          final uid = auth.currentUser!.uid;
          final state = builderKey.currentState!.fields;
          final imageFile = state['photo']!.value.first;
          final imagePath = imageFile.path;
          final filename = path.basename(imagePath);

          final storageRef = storage.ref().child(
                'users/$uid/profile/$filename',
              );

          final imageBytes = await imageFile.readAsBytes();

          final image = img.decodeImage(imageBytes)!;
          final resizedImage = await compute(cpyResize, image);
          final resizedImageBytes = Uint8List.fromList(
            img.encodeJpg(resizedImage),
          );

          await storageRef.putData(resizedImageBytes);

          final link = await storageRef.getDownloadURL();
          final data = {
            "phoneNumber": state['phoneNo']!.value,
            "studentNumber": state["studentNo"]?.value ?? "",
            "name": state['uname']!.value,
            "profilePicture": PProfilePicture(
              link: link,
              width: resizedImage.width,
              height: resizedImage.height,
            ).toJson()
          };

          await db.doc('users/$uid').update(data);
          ref.read(authProvider.notifier).isFirstTime = false;
          ref.refresh(pCurrentUserProvider);

          context.go('/');
        }
      },
      child: Text(translations.continueButtonTitle),
    );
  }
}

img.Image cpyResize(img.Image image) {
  return img.copyResizeCropSquare(image, 120);
}
