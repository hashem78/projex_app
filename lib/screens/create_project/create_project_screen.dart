import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/models/permission/permission_model.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/auth.dart';
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: FormBuilder(
          key: createProjectKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 16.0,
                  children: [
                    Text(
                      'Enter your new project\'s name',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    FormBuilderTextField(
                      name: "name",
                      decoration: const InputDecoration(
                        hintText: "Name",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(15),
                        FormBuilderValidators.minLength(5),
                      ]),
                    ),
                    SizedBox(
                      height: 5 * 24.0,
                      child: FormBuilderTextField(
                        maxLines: 5,
                        name: "desc",
                        decoration: const InputDecoration(
                          hintText: "Description",
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(50),
                          FormBuilderValidators.minLength(10),
                        ]),
                      ),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'start',
                      inputType: InputType.both,
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      decoration: const InputDecoration(
                        labelText: 'Start date',
                      ),
                      initialDate: DateTime.now(),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'end',
                      inputType: InputType.both,
                      decoration: const InputDecoration(
                        labelText: 'End date',
                      ),
                      format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderSwitch(
                      name: 'public',
                      decoration: const InputDecoration(border: InputBorder.none),
                      validator: FormBuilderValidators.required(),
                      title: Text(
                        'Make your project public',
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      initialValue: true,
                    ),
                    SizedBox(
                      width: 1.sw,
                      child: OutlinedButton(
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
                            final public = state['public']!.value as bool;

                            final project = PProject(
                              creatorId: uid,
                              id: pid,
                              name: pname,
                              description: desc,
                              startDate: startDate,
                              endDate: endDate,
                              public: public,
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
                            await user.assignRoleToUser(
                              projectId: pid,
                              userId: user.id,
                              role: role,
                            );
                          }
                        },
                        child: const Text("Create Project"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
