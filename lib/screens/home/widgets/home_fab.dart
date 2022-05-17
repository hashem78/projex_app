import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeFAB extends StatelessWidget {
  const HomeFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        context.push('/createProject');
      },
    );
  }
}
