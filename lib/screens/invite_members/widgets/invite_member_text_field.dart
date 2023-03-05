import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/invite_members/invite_members_screen.dart';
import 'package:projex_app/state/add_members.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';

class InviteMembersEmailField extends ConsumerWidget {
  const InviteMembersEmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.inviteMembersPage;

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: FormBuilderTextField(
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
              icon: const Icon(Icons.search),
              onPressed: () async {
                final isValid = inviteMembersKey.currentState!.validate();

                if (isValid) {
                  final project = ref.read(projectProvider);
                  final db = FirebaseFirestore.instance;
                  final state = inviteMembersKey.currentState!;
                  final emailState = state.fields['email']!;
                  final query = await db
                      .collection('users')
                      .where(
                        'email',
                        isEqualTo: emailState.value,
                      )
                      .withConverter(
                        fromFirestore: (u, _) => PUser.fromJson(u.data()!),
                        toFirestore: (_, __) => {},
                      )
                      .get();

                  if (query.size == 0) {
                    state.invalidateFirstField(errorText: translations.userDoesNotExistError);
                  } else {
                    final user = query.docs.first.data();
                    if (project.memberIds.contains(user.id)) {
                      state.invalidateFirstField(errorText: translations.userIsAlreadyAMemberErrorText);
                    } else if (project.joinRequests.contains(user.id)) {
                      state.invalidateFirstField(errorText: translations.userHasAPendingRequestErrorText);
                    } else if (project.invitations.contains(user.id)) {
                      state.invalidateFirstField(errorText: translations.userHasAPendingInviteErrorText);
                    } else {
                      ref.read(memberEmailsProvider.notifier).add(user);
                    }
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
