import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:projex_app/state/locale.dart';

class UsernameTextField extends ConsumerWidget {
  const UsernameTextField({
    Key? key,
    required this.usernameController,
  }) : super(key: key);

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: usernameController,
        keyboardType: TextInputType.name,
        validator: RequiredValidator(
          errorText: translations.errorRequiredTextInputField,
        ),
        decoration: InputDecoration(hintText: translations.usernameHint),
      ),
    );
  }
}
