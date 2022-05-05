import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:projex_app/enums/registration_type.dart';

import 'package:projex_app/screens/registration/widgets/change_pfp_avatar.dart';
import 'package:projex_app/screens/registration/widgets/phone_number_textfield.dart';
import 'package:projex_app/screens/registration/widgets/registartion_button.dart';
import 'package:projex_app/screens/registration/widgets/registration_title.dart';
import 'package:projex_app/screens/registration/widgets/std_text_field.dart';
import 'package:projex_app/screens/registration/widgets/username_textfield.dart';

final builderKey = GlobalKey<FormBuilderState>();

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    Key? key,
    required this.registrationType,
  }) : super(key: key);

  final RegistrationType registrationType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: FormBuilder(
          key: builderKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16.0,
                children: [
                  const CompeleteRegistrationTitle(),
                  const ChangePfpAvatar(),
                  const UsernameTextField(),
                  const PhoneNumberTextField(),
                  if (registrationType == RegistrationType.student)
                    const STDNumTextField(),
                  const RegistrationButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
