import 'package:flutter/material.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/add_roles_appbar_title.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/roles_listview.dart';

class AddRolesToUserScreen extends StatelessWidget {
  const AddRolesToUserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AddRolesAppBarTitle(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text("Roles"),
          ),
          RolesListView(),
        ],
      ),
    );
  }
}
