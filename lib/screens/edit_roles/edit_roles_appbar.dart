import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/role_model/role.dart';

class EditRoleScreenAppBar extends StatelessWidget {
  const EditRoleScreenAppBar({
    Key? key,
    required this.role,
  }) : super(key: key);
  final PRole role;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Edit Role - ${role.name}'),
      backgroundColor: Color(int.parse(role.color, radix: 16)),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      bottom: const TabBar(
        tabs: [
          Tab(text: 'Display'),
          Tab(text: 'Permissions'),
          Tab(text: 'Manage'),
        ],
      ),
    );
  }
}
