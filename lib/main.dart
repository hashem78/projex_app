import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:projex_app/firebase_options.dart';
import 'package:projex_app/state/router_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For debugging purposes.
  // Make sure to run firebase eumlators:start
  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  await dotenv.load(fileName: "assets/env.dat");

  // TODO: Add more sign in providers
  FlutterFireUIAuth.configureProviders(
    [
      GoogleProviderConfiguration(clientId: dotenv.env['GOOGLE_CLIENT_ID']!),
    ],
  );
  runApp(
    const ProviderScope(
      child: App(),
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

    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (context) {
        if (kIsWeb || Platform.isAndroid) {
          return MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        } else {
          return CupertinoApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        }
      },
    );
  }
}
