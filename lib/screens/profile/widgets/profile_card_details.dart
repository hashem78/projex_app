import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/user_model/user_model.dart';

class ProfileScreenCardDetails extends ConsumerWidget {
  final PUser user;
  const ProfileScreenCardDetails({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          user.name,
          maxLines: 1,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          user.email,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
