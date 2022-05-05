import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:projex_app/state/locale.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PhoneNumberTextField extends ConsumerWidget {
  const PhoneNumberTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return FormBuilderTextField(
      name: "phoneNo",
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp("[0-9]"),
        ),
        LengthLimitingTextInputFormatter(10),
      ],
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.numeric(),
          FormBuilderValidators.minLength(
            10,
            errorText: translations.errorMinlength(n: 10),
          ),
          FormBuilderValidators.maxLength(
            10,
            errorText: translations.errorMaxlength(n: 10),
          ),
          FormBuilderValidators.required(
            errorText: translations.errorRequiredTextInputField,
          ),
        ],
      ),
      decoration: InputDecoration(
        hintText: translations.phoneNumberHint,
      ),
    );
  }
}
