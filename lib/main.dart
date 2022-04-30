import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:projex_app/firebase_options.dart';
import 'package:projex_app/i18n/translations.g.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/router_provider.dart';
import 'package:projex_app/state/shared_perferences_provider.dart';
import 'package:projex_app/state/theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For debugging purposes.
  // Make sure to run firebase eumlators:start
  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  // Loads the SharedPereferences instance for later
  // overriding.
  final prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/env.dat");

  // TODO: Add more sign in providers
  FlutterFireUIAuth.configureProviders(
    [
      GoogleProviderConfiguration(clientId: dotenv.env['GOOGLE_CLIENT_ID']!),
    ],
  );
  runApp(
    ProviderScope(
      overrides: [
        // Override the SharedPereferences Provider with the
        // instance we just loaded.
        sharedPerferencesProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return the appropriate platform based on the current platform
    // package:go_rotuer handels displaying the correct transitions.

    final router = ref.watch(routerProvider);
    // The current theme mode for this App
    final themeState = ref.watch(themeModeProvider);
    // The current translations + locale for this App
    final translations = ref.watch(translationProvider);
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (context) {
        if (kIsWeb || Platform.isAndroid) {
          return MaterialApp.router(
            locale: translations.locale.flutterLocale,
            // We support the locales in AppLocale, but AppLocale locales
            // are different and need to be mapped to flutter locales.
            supportedLocales: AppLocale.values.map((e) => e.flutterLocale),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            themeMode: themeState.themeMode,
            theme: ThemeData(brightness: themeState.brightness),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        } else {
          return CupertinoApp.router(
            locale: translations.locale.flutterLocale,
            // We support the locales in AppLocale, but AppLocale locales
            // are different and need to be mapped to flutter locales.
            supportedLocales: AppLocale.values.map((e) => e.flutterLocale),
            localizationsDelegates: GlobalCupertinoLocalizations.delegates,
            theme: CupertinoThemeData(brightness: themeState.brightness),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        }
      },
    );
  }
}
