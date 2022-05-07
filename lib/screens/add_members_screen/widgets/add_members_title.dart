import 'package:flutter/material.dart';

class AddMemberScreenTitle extends StatelessWidget {
  const AddMemberScreenTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Add new members to this project",
      style: Theme.of(context).textTheme.headline3,
      textAlign: TextAlign.center,
    );
  }
}
