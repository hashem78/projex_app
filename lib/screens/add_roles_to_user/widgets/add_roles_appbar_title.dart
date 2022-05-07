import 'package:flutter/material.dart';

class AddRolesAppBarTitle extends StatelessWidget {
  const AddRolesAppBarTitle({
    Key? key,
    required this.projectName,
    required this.userName,
  }) : super(key: key);
  final String projectName;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectName,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        Text(
          userName,
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        )
      ],
    );
  }
}
