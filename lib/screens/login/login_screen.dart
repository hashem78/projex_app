import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart' as fui10n;
import 'package:projex_app/i18n/translations.g.dart';
import 'package:projex_app/screens/login/widgets/login_screen_toggle_language_button.dart';

/// The strings package:flutterfire_ui uses for localizing are translated
/// by extending/implementing the fui10n.DefaultLocalizations class.
class LoginLocalilzations extends fui10n.DefaultLocalizations {
  // The translations object needed to find the strings.
  final TranslationsEn _t;
  const LoginLocalilzations(this._t);
  @override
  String get signInWithGoogleButtonText => _t.login.signInWithGoogleButtonText;

  @override
  String get signInText => _t.login.signInText;

  @override
  String get registerText => _t.login.registerText;

  @override
  String get registerHintText => _t.login.registerHintText;

  @override
  String get signInHintText => _t.login.signInHintText;
}

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
