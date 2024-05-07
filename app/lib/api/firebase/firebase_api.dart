import 'dart:convert';

import 'package:app/api/firebase/notification_type.dart';
import 'package:app/api/hw-notification/index.dart';
import 'package:app/api/invitation/model/invitation_model.dart';
import 'package:app/api/location/exception/index.dart';
import 'package:app/api/location/exception/location_access_denied_excepion.dart';
import 'package:app/api/location/location_repository.dart';
import 'package:app/api/user/user_repository.dart';
import 'package:app/feature/home/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';
import 'package:app/util/route/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {}

Future<String?> _updateAppState(RemoteMessage? message) async {
  if (message == null) {
    return null;
  }

  final locationRepository = DependencyInjection.getIt<LocationRepository>();
  final userRepsitory = DependencyInjection.getIt<UserRepository>();

  final notificationType = message.data['notificationType'];

  if (notificationType == NotificationType.inactiveDevice.name ||
      notificationType == NotificationType.deviceStateReport.name) {
    final hwNotification = HwNotificationModel.fromJson(jsonDecode(message.data['body']));
    userRepsitory.addHwNotification(hwNotification);
  } else if (notificationType == NotificationType.locationUpdate.name) {
    final locationId = jsonDecode(message.data['body'])['locationId'];

    try {
      final location = await locationRepository.getLocation(locationId);
      userRepsitory.updateLocationsList(location);
      await locationRepository.fetchLocationInsights(locationId);
    } on LocationNotFoundException {
      userRepsitory.removeLocationFromList(locationId);
      locationRepository.removeLocationInsights(locationId);
      return AppStrings.deletedLocation;
    } on LocationAccessDeniedException {
      userRepsitory.removeLocationFromList(locationId);
      locationRepository.removeLocationInsights(locationId);
      return AppStrings.locationAccessDenied;
    }
  } else if (notificationType == NotificationType.invitation.name) {
    final invitation = InvitationModel.fromJson(jsonDecode(message.data['body']));
    userRepsitory.addInvitation(invitation);
  } else if (notificationType == NotificationType.invitationUpdate.name) {
    final invitationId = jsonDecode(message.data['body'])['invitationId'];
    userRepsitory.removeInvitation(invitationId);
  } else if (notificationType == NotificationType.hwNotificationUpdate.name) {
    final hwNotificationId = jsonDecode(message.data['body'])['hwNotificationId'];
    userRepsitory.removeHwNotification(hwNotificationId);
  }

  return null;
}

class FirebaseApi extends ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidNotificationChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _navigationService = DependencyInjection.getIt<NavigationService>();
  late String _message;

  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> _handleMessage(RemoteMessage? message) async {
    if (message != null) {
      _message = await _updateAppState(message) ?? '';
      await _navigationService.clearStackAndShow(RouteEnum.home.name, arguments: PageEnum.notifications.value);
      notifyListeners();
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
    FirebaseMessaging.onMessage.listen((message) async {
      _message = await _updateAppState(message) ?? '';
      notifyListeners();

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

    final platform =
        _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidNotificationChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await _initPushNotifications();
    await _initLocalNotifications();
  }

  String get message => _message;
}
