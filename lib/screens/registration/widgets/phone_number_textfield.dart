import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:projex_app/state/locale.dart';

class PhoneNumberTextField extends ConsumerWidget {
  const PhoneNumberTextField({
    Key? key,
    required this.phoneNumberController,
  }) : super(key: key);
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: phoneNumberController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: translations.phoneNumberHint,
        ),
        validator: MultiValidator(
          [
            MinLengthValidator(
              10,
              errorText: translations.phoneNumberErrorText,
            ),
            RequiredValidator(
              errorText: translations.errorRequiredTextInputField,
            ),
          ],
        ),
      ),
    );
  }
}
