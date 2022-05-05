import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projex_app/state/locale.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UsernameTextField extends ConsumerWidget {
  const UsernameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return FormBuilderTextField(
      name: "uname",
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
      ],
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.minLength(
            6,
            errorText: translations.errorMinlength(n: 6),
          ),
          FormBuilderValidators.maxLength(
            15,
            errorText: translations.errorMaxlength(n: 15),
          ),
          FormBuilderValidators.required(
            errorText: translations.errorRequiredTextInputField,
          ),
        ],
      ),
      decoration: InputDecoration(
        hintText: translations.usernameHint,
      ),
    );
  }
}
