import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projex_app/state/locale.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class STDNumTextField extends ConsumerWidget {
  const STDNumTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;

    return FormBuilderTextField(
      name: "stdNo",
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp("[0-9]"),
        ),
      ],
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.numeric(),
          FormBuilderValidators.required(
            errorText: translations.errorRequiredTextInputField,
          ),
        ],
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: translations.studentNumberHint,
      ),
    );
  }
}
