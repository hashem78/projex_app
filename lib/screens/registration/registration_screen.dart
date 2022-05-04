import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/enums/picker_user.dart';
import 'package:projex_app/enums/registration_type.dart';
import 'package:projex_app/screens/registration/widgets/change_pfp_avatar.dart';
import 'package:projex_app/screens/registration/widgets/phone_number_textfield.dart';
import 'package:projex_app/screens/registration/widgets/registartion_button.dart';
import 'package:projex_app/screens/registration/widgets/registration_title.dart';
import 'package:projex_app/screens/registration/widgets/std_text_field.dart';
import 'package:projex_app/screens/registration/widgets/username_textfield.dart';
import 'package:projex_app/state/image_picking.dart';
import 'package:projex_app/state/locale.dart';

final formKey = GlobalKey<FormState>();

class RegistrationScreen extends HookConsumerWidget {
  const RegistrationScreen({
    Key? key,
    required this.registrationType,
  }) : super(key: key);

  final RegistrationType registrationType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final stdNumberController = registrationType == RegistrationType.student
        ? useTextEditingController()
        : null;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CompeleteRegistrationTitle(),
                  _buildText(ref),
                  const ChangePfpAvatar(),
                  UsernameTextField(
                    usernameController: usernameController,
                  ),
                  PhoneNumberTextField(
                    phoneNumberController: phoneNumberController,
                  ),
                  if (registrationType == RegistrationType.student)
                    STDNumTextField(
                      stdNumberController: stdNumberController!,
                    ),
                  RegistrationButton(
                    username: usernameController,
                    stdNumber: stdNumberController,
                    phoneNumber: phoneNumberController,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(WidgetRef ref) {
    final imagePicker = ref.watch(
      imagePickerProvier(PickerUse.signup),
    );
    final translations =
        ref.watch(translationProvider).translations.registration;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: imagePicker.when(
        picked: (_) => const SizedBox(),
        notPicked: () => Text(
          translations.profilePicturePickText,
        ),
        error: () => Text(
          translations.profilePicturePickErrorText,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
