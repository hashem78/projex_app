import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/editing.dart';

class ProfileScreenCardDetails extends ConsumerWidget {
  const ProfileScreenCardDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final isEditing = ref.watch(editingProvider(EditReason.profile));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!isEditing)
          Text(
            user.name,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline5,
          ),
        if (isEditing)
          FormBuilderTextField(
            name: 'disName',
            initialValue: user.name,
            autofocus: true,
            style: Theme.of(context).textTheme.headline5,
            decoration: const InputDecoration(border: InputBorder.none),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.minLength(3),
          ),
        Text(
          user.email,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
