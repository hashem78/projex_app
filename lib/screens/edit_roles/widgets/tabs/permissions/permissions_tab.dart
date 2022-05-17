import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/models/permission/permission_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projex_app/state/project_provider.dart';

class PermissionsTab extends ConsumerWidget {
  const PermissionsTab({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;
  static const _perms = PPermission.values;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: _perms.length,
      itemBuilder: (context, index) {
        final perm = _perms[index];
        return FormBuilderSwitch(
          initialValue: role.permissions.contains(perm),
          enabled: perm == const PPermission.admin() || !role.permissions.contains(const PPermission.admin()),
          onChanged: (val) async {
            final project = ref.read(projectProvider);
            if (val == null) return;
            if (val) {
              final newPerms = {
                ...role.permissions,
                perm,
              };
              await project.editRole(
                role.copyWith(permissions: newPerms),
              );
            } else {
              final newPerms = {...role.permissions};
              newPerms.remove(perm);
              await project.editRole(
                role.copyWith(permissions: newPerms),
              );
            }
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          name: perm.fieldName,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              perm.title,
              style: TextStyle(fontSize: 40.sp),
            ),
          ),
        );
      },
    );
  }
}
