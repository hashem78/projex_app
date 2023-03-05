import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/locale.dart';

class EditRoleScreenAppBar extends ConsumerWidget {
  const EditRoleScreenAppBar({
    Key? key,
    required this.role,
  }) : super(key: key);
  final PRole role;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.editRolePage;
    return SliverAppBar(
      title: Text('${translations.editRoleAppBarTitle} - ${role.name}'),
      backgroundColor: Color(int.parse(role.color, radix: 16)),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      bottom: TabBar(
        tabs: [
          Tab(text: translations.displayTabBarTitle),
          Tab(text: translations.permissionsTabBarTitle),
          Tab(text: translations.manageTabBarTitle),
        ],
      ),
    );
  }
}
