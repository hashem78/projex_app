import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/locale.dart';

class JoinProjectDialog extends ConsumerStatefulWidget {
  const JoinProjectDialog({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<JoinProjectDialog> createState() => _JoinProjectDialogState();
}

class _JoinProjectDialogState extends ConsumerState<JoinProjectDialog> {
  final k = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final translations = ref.watch(translationProvider).translations.home;
    return AlertDialog(
      title: Text(translations.joinProjectDialogTitle),
      content: SizedBox(
        width: 0.8.sw,
        child: FormBuilder(
          key: k,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(translations.joinProjectDialogSubTitle),
              FormBuilderTextField(
                name: 'piid',
                maxLines: 1,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    // FormBuilderValidators.minLength(5),
                    // FormBuilderValidators.maxLength(10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(translations.joinProjectDialogCancelButtonText),
        ),
        TextButton(
          onPressed: () async {
            final isValid = k.currentState!.validate();
            final state = k.currentState!.fields;
            if (isValid) {
              final pId = state['piid']!.value;
              final user = ref.read(authProvider);
              final projectQuery = await FirebaseFirestore.instance
                  .collection(
                    '/projects',
                  )
                  .where(
                    'id',
                    isEqualTo: pId,
                  )
                  .get();

              if (projectQuery.size != 0) {
                final projectJson = projectQuery.docs.first.data();
                final project = PProject.fromJson(projectJson);
                if (project.memberIds.contains(user.id)) {
                  k.currentState!.fields['piid']!.invalidate('You are already in this Project!');
                } else {
                  if (project.invitations.contains(user.id)) {
                    k.currentState!.fields['piid']!.invalidate('You already have an invitation to this project');
                  } else if (project.joinRequests.contains(user.id)) {
                    k.currentState!.fields['piid']!.invalidate('You have already requested to join this project.');
                  } else {
                    await user.requestToJoin(project.id);

                    if (!mounted) return;
                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                      const SnackBar(
                        content: Text('An invitation request has been sent'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                }
              } else {
                k.currentState!.fields['piid']!.invalidate('This project does not exist!');
              }
            }
          },
          child: Text(translations.joinProjectDialogJoinButtonText),
        ),
      ],
    );
  }
}
