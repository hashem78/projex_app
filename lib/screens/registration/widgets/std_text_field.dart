import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:projex_app/state/locale.dart';

class STDNumTextField extends ConsumerWidget {
  const STDNumTextField({
    Key? key,
    required this.stdNumberController,
  }) : super(key: key);

  final TextEditingController stdNumberController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: stdNumberController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        keyboardType: TextInputType.number,
        validator: MultiValidator(
          [
            RequiredValidator(
              errorText: translations.errorRequiredTextInputField,
            ),
            MinLengthValidator(
              5,
              errorText: translations.errorRequiredTextInputField,
            ),
          ],
        ),
        decoration: InputDecoration(
          hintText: translations.studentNumberHint,
        ),
      ),
    );
  }
}
