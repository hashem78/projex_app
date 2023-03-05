import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/models/permission/permission_model.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/locale.dart';
import 'package:uuid/uuid.dart';

class CreateProjectScreen extends ConsumerStatefulWidget {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends ConsumerState<CreateProjectScreen> {
  final createProjectKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final translations = ref.watch(translationProvider).translations;
    final locale = ref.watch(translationProvider).locale;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: FormBuilder(
          key: createProjectKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: 0.25.sh,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(translations.createProject.createProjectTitle),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      FormBuilderTextField(
                        name: "name",
                        decoration: InputDecoration(
                          hintText: translations.createProject.projectNameTextFieldLabel,
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxLength(30),
                            FormBuilderValidators.minLength(5),
                          ],
                        ),
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: 5 * 24.0,
                        child: FormBuilderTextField(
                          maxLines: 5,
                          name: "desc",
                          decoration: InputDecoration(
                            hintText: translations.createProject.projectDescriptionTextFieldLabel,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxLength(100),
                            FormBuilderValidators.minLength(10),
                          ]),
                        ),
                      ),
                      16.verticalSpace,
                      FormBuilderDateTimePicker(
                        name: 'start',
                        inputType: InputType.both,
                        format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", locale.name),
                        decoration: InputDecoration(
                          labelText: translations.createProject.projectStartDateFieldLabel,
                        ),
                        initialDate: DateTime.now(),
                        validator: FormBuilderValidators.required(),
                      ),
                      16.verticalSpace,
                      FormBuilderDateTimePicker(
                        name: 'end',
                        inputType: InputType.both,
                        decoration: InputDecoration(
                          labelText: translations.createProject.projectEndDateFieldLabel,
                        ),
                        format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma", locale.name),
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        validator: FormBuilderValidators.required(),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: 1.sw,
                  child: TextButton(
                    onPressed: () async {
                      final isValid = createProjectKey.currentState!.validate();
                      if (isValid) {
                        final state = createProjectKey.currentState!.fields;
                        const uuid = Uuid();
                        final uid = ref.read(authProvider).id;
                        final pid = uuid.v4();
                        final pname = state['name']!.value as String;
                        final desc = state['desc']!.value as String;
                        final startDate = state['start']!.value as DateTime;
                        final endDate = state['end']!.value as DateTime;

                        final project = PProject(
                          creatorId: uid,
                          id: pid,
                          name: pname,
                          description: desc,
                          startDate: startDate,
                          endDate: endDate,
                          memberIds: {uid},
                          userRoleMap: {
                            uid: {'owner'}
                          },
                        );
                        final user = ref.read(authProvider);
                        await user.createProject(project: project);
                        final role = PRole(
                          color: Colors.red.value.toRadixString(16),
                          id: 'owner',
                          name: 'Owner',
                          permissions: {
                            const PPermission.owner(),
                          },
                        );
                        await project.createRole(role);
                        await project.assignRoleToUser(
                          userId: user.id,
                          role: role,
                        );
                        if (!mounted) return;
                        context.pop();
                        context.push('/project/$pid');
                      }
                    },
                    child: Text(translations.createProject.createProjectButtonText),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
