import 'package:flutter/material.dart';
import 'package:projex_app/models/role_model/role.dart';

class NumberOfMembersThatHaveRoleTile extends StatelessWidget {
  const NumberOfMembersThatHaveRoleTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.people,
        color: Colors.blue,
      ),
      title: Text('${role.count} members have this role'),
    );
  }
}
