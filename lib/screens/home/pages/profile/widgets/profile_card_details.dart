import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/auth.dart';

class ProfileScreenCardDetails extends ConsumerWidget {
  const ProfileScreenCardDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          user.name,
          maxLines: 1,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
