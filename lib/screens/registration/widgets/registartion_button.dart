import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/enums/picker_user.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/screens/registration/registration_screen.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/image_picking.dart';
import 'package:path/path.dart' as path;
import 'package:projex_app/state/locale.dart';

class RegistrationButton extends ConsumerWidget {
  const RegistrationButton({
    Key? key,
    required this.username,
    required this.phoneNumber,
    this.stdNumber,
  }) : super(key: key);

  final TextEditingController username;
  final TextEditingController phoneNumber;
  final TextEditingController? stdNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return TextButton(
      onPressed: () {
        final auth = FirebaseAuth.instance;
        final storage = FirebaseStorage.instance;
        final db = FirebaseFirestore.instance;
        final valid = formKey.currentState!.validate();
        final pickerValid = ref
            .read(
              imagePickerProvier(PickerUse.signup).notifier,
            )
            .validate();

        if (valid && pickerValid) {
          final pickerState = ref.read(
            imagePickerProvier(PickerUse.signup),
          );
          pickerState.whenOrNull(
            picked: (img) async {
              final uid = auth.currentUser!.uid;
              final filename = path.basename(img.first.path);

              final storageRef = storage.ref().child(
                    'users/$uid/profile/$filename',
                  );
              await storageRef.putData(img.first.byteData);
              final link = await storageRef.getDownloadURL();
              final data = {
                "phoneNumber": phoneNumber.text,
                "name": username.text,
                "profilePicture": PProfilePicture(
                  link: link,
                  width: img.first.width,
                  height: img.first.height,
                ).toJson()
              };
              if (stdNumber != null) {
                data["studentNumber"] = stdNumber!.text;
              }
              await db.doc('users/$uid').update(data);
              ref.read(authProvider.notifier).isFirstTime = false;
              ref.refresh(pCurrentUserProvider);
              ref.refresh(imagePickerProvier(PickerUse.signup));
              context.go('/');
            },
          );
        }
      },
      child: Text(translations.continueButtonTitle),
    );
  }
}
