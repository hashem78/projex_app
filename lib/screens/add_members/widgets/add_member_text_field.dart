import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/add_members/add_members_screen.dart';
import 'package:projex_app/state/add_members.dart';

class AddMemberEmailField extends ConsumerWidget {
  const AddMemberEmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilderTextField(
      name: "email",
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ],
      ),
      decoration: InputDecoration(
        hintText: "Email",
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            final isValid = addMemberKey.currentState!.validate();

            if (isValid) {
              final db = FirebaseFirestore.instance;
              final state = addMemberKey.currentState!;
              final emailState = state.fields['email']!;
              final query = await db
                  .collection('users')
                  .where(
                    'email',
                    isEqualTo: emailState.value,
                  )
                  .get();
              if (query.size == 0) {
                state.invalidateFirstField(errorText: 'This email does not exist');
              } else {
                final user = query.docs.first.data();
                ref.read(memberEmailsProvider.notifier).add(PUser.fromJson(user));
              }
            }
          },
        ),
      ),
    );
  }
}
