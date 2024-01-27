import 'dart:convert';

import 'package:app/feature/home/index.dart';
import 'package:app/util/dependency_injection/index.dart';
import 'package:app/util/route/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidNotificationChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  void _handleMessage(RemoteMessage? message) {
    if (message != null) {
      _navigationService.clearStackAndShow(RouteEnum.home.name, arguments: PageEnum.notifications.value);
    }
  }

  Future<void> _initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidNotificationChannel.id,
              _androidNotificationChannel.name,
              channelDescription: _androidNotificationChannel.description,
              icon: '@mipmap/ic_launcher', // TODO: change
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future<void> _initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher'); // TODO: change image here too
    const settings = InitializationSettings(iOS: iOS, android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) async {
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        _handleMessage(message);
      },
    );

    // TODO: check for iOS

    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidNotificationChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await _initPushNotifications();
    await _initLocalNotifications();
  }
}
