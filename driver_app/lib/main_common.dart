import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'firebase_options.dart';

// import 'flavor_config.dart';
import 'flavor_config.dart';
import 'my_app.dart';

import 'shared/repository/local/local_storage_repo.dart';
import 'shared/services/service_locator.dart';
import 'shared/services/remote/push_notification_service.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.initServices();
  await GetStorage.init();

  // Init firebase app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(handleMessage);
    await FirebasePushApiService().initNotification();
  }

  final Locale locale = await ServiceLocator.get<LocalStorageRepo>().getCurrentLocale();

  if (AppFlavor.env == Env.prod) {
    await SentryFlutter.init(
      (SentryFlutterOptions options) {
        options.dsn = AppFlavor.sentryDsn;
      },
      appRunner: () => runApp(MyApp(locale: locale)),
    );
  } else {
    runApp(MyApp(locale: locale));
  }
}
