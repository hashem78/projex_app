import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:projex_app/firebase_options.dart';
import 'package:projex_app/i18n/translations.g.dart';
import 'package:projex_app/screens/login/login_localizations.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/notifications.dart';
import 'package:projex_app/state/router_provider.dart';
import 'package:projex_app/state/shared_perferences_provider.dart';
import 'package:projex_app/state/theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const androidChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);
const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
const notificationSettings = InitializationSettings(android: androidSettings);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For debugging purposes.
  // Make sure to run firebase eumlators:start
  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  }
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  await flutterLocalNotificationsPlugin.initialize(
    notificationSettings,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    },
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);
  FirebaseMessaging.onMessage.listen(
    (message) {
      final notification = message.notification;
      final android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
            ),
          ),
        );
      }
    },
  );
  await setupTokenRefreshListener();
  // Loads the SharedPereferences instance for later
  // overriding.
  final prefs = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/env.dat");

  FlutterFireUIAuth.configureProviders(
    [
      const EmailProviderConfiguration(),
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
      designSize: const Size(1080, 2340),
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: translations.locale.flutterLocale,
          // We support the locales in AppLocale, but AppLocale locales
          // are different and need to be mapped to flutter locales.
          supportedLocales: AppLocale.values.map((e) => e.flutterLocale),
          localizationsDelegates: [
            ...GlobalMaterialLocalizations.delegates,
            GlobalWidgetsLocalizations.delegate,
            // override the default pacakage:flutterfire_ui strings
            FlutterFireUILocalizations.withDefaultOverrides(
              LoginLocalilzations(translations.translations),
            ),
            FormBuilderLocalizations.delegate,
          ],
          themeMode: themeState.flutterThemeMode,
          theme: ThemeData(
            brightness: themeState.flutterBrightness,
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              filled: true,
            ),
          ),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
        );
      },
    );
  }
}
