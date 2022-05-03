import 'package:flutter/material.dart';
import 'package:projex_app/screens/first_time_sign_in/widgets/first_screen_title.dart';

import 'package:projex_app/screens/first_time_sign_in/widgets/instructor_selection_tile.dart';
import 'package:projex_app/screens/first_time_sign_in/widgets/student_selection_tile.dart';

class FirstTimeSignInScreen extends StatelessWidget {
  const FirstTimeSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FirstTimeScreenTitle(),
              InstructorSelectionTile(),
              StudentSelectionTile(),
            ],
          ),
        ),
      ),
    );
  }
}
