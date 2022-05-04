import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:projex_app/screens/login/widgets/login_screen_toggle_language_button.dart';

// TODO: Check if we need other things here
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      resizeToAvoidBottomInset: true,
      headerBuilder: (context, constraints, shrinkOffset) {
        return Row(
          children: const [
            LoginScreenToggleLanguageButton(),
          ],
        );
      },
    );
  }
}
