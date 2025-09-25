import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'my_app.dart';
import 'firebase_options.dart';
import 'shared/repository/local/local_storage_repo.dart';
import 'shared/repository/local/orientation_repo.dart';
import 'shared/repository/remote/crashlytics_repo.dart';
import 'shared/services/service_locator.dart';
import 'shared/services/remote/push_notification_service.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator.initServices();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase Crashlytics
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Set up global error handlers for automatic crash reporting
  ServiceLocator.get<CrashlyticsRepo>().recordFatalError();

  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(handleMessage);
    await FirebasePushApiService().initNotification();
  }

  // Set the device orientation to portrait
  await ServiceLocator.get<OrientationRepo>().portraitOrientation();

  // Get current locale
  final Locale locale = await ServiceLocator.get<LocalStorageRepo>().getCurrentLocale();

  runApp(MyApp(locale: locale));

  // if (AppFlavor.env == Env.prod) {
  //   await SentryFlutter.init((SentryFlutterOptions options) {
  //     options.dsn = AppFlavor.sentryDsn;
  //     options.enableNativeCrashHandling = false; // disables NDK integrations
  //     options.debug = false;
  //   }, appRunner: () => runApp(MyApp(locale: locale)));
  // } else {
  //   runApp(MyApp(locale: locale));
  // }
}
