import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';

import '../../repository/local/local_storage_repo.dart';
import '../service_locator.dart';

// Called when the app is destroyed
@pragma('vm:entry-point')
Future<void> handleMessage(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint('::::onDestroy::::');
    debugPrint('\nNotification Title: ${message.notification?.title}');
    debugPrint('\nNotification Body: ${message.notification?.body}');
    debugPrint('\nNotification Payload (${message.data.runtimeType}): ${message.data}');
    await GetStorage.init();
    ServiceLocator.get<LocalStorageRepo>().savePushPayload(payload: message.data);
  }
}

class FirebasePushApiService {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<String?> getFcmToken() async {
    try {
      final fcmToken = await firebaseMessaging.getToken();
      debugPrint('Device FCM token is: $fcmToken');
      return fcmToken;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  final AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await getUserPermission();
    await initPushNotification();
    await initLocalNotification();
  }

  Future<void> firebaseMessagingBackgroundHandler() async {
    FirebaseMessaging.onBackgroundMessage(handleMessage);
  }

  Future<void> initPushNotification() async {
    // for IOS
    firebaseMessaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    // Get any messages which caused the application to open from a terminated state.
    firebaseMessaging.getInitialMessage().then((value) => handleMessage);
    // Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // Get any messages application in foreground
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
  }

  Future<void> handleForegroundMessage(RemoteMessage? message) async {
    debugPrint('::::onForegroundMessage::::');
    debugPrint('\nNotification Title: ${message?.notification?.title}');
    debugPrint('\nNotification Body: ${message?.notification?.body}');
    debugPrint('\nNotification Payload(${message?.data.runtimeType}): ${message?.data}');

    final accessToken = await ServiceLocator.get<LocalStorageRepo>().getAccessToken();

    if (accessToken != null && message != null) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification == null) return;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id, androidChannel.name,
              icon: android.smallIcon, //'@drawable/ic_launcher'
              importance: Importance.high,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    }
  }

  Future<void> handleMessage(RemoteMessage message) async {
    debugPrint('::::handle backgroundMessage::::');
    debugPrint('\nNotification Title: ${message.notification?.title}');
    debugPrint('\nNotification Body: ${message.notification?.body}');
    debugPrint('\nNotification Payload: ${message.data}');

    if (message.notification != null) {
      await ServiceLocator.get<LocalStorageRepo>().savePushPayload(payload: message.data);
    }
  }

  Future<void> getUserPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> initLocalNotification() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.initialize(settings, onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
      handleMessage(message);
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  // Display local notification
  void showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) {
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
        ),
      ),
      payload: payload,
    );
  }
}
